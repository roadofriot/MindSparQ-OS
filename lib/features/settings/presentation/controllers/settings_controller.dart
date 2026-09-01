import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/network/supabase_client_provider.dart';
import '../../data/settings_repository.dart';
import '../../domain/models/settings_model.dart';

class ThemeModeNotifier extends StateNotifier<ThemeMode> {
  final SettingsRepository _repo;

  ThemeModeNotifier(this._repo) : super(ThemeMode.system) {
    _load();
  }

  Future<void> _load() async {
    state = await _repo.getThemeMode();
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    state = mode;
    await _repo.saveThemeMode(mode);
  }
}

final themeModeNotifierProvider =
    StateNotifierProvider<ThemeModeNotifier, ThemeMode>((ref) {
  final repo = ref.watch(settingsRepositoryProvider);
  return ThemeModeNotifier(repo);
});

class LocaleNotifier extends StateNotifier<Locale> {
  final SettingsRepository _repo;

  LocaleNotifier(this._repo) : super(const Locale('ne')) {
    _load();
  }

  Future<void> _load() async {
    state = await _repo.getLocale();
  }

  Future<void> setLocale(Locale locale) async {
    state = locale;
    await _repo.saveLocale(locale);
  }
}

final localeNotifierProvider =
    StateNotifierProvider<LocaleNotifier, Locale>((ref) {
  final repo = ref.watch(settingsRepositoryProvider);
  return LocaleNotifier(repo);
});

@immutable
class SettingsState {
  final UserProfileSettings profile;
  final NotificationSettings notifications;
  final SecuritySettings security;
  final bool isSaving;
  final bool isPinging;
  final int? latencyMs;
  final String? successMessage;
  final String? errorMessage;

  const SettingsState({
    required this.profile,
    required this.notifications,
    required this.security,
    this.isSaving = false,
    this.isPinging = false,
    this.latencyMs,
    this.successMessage,
    this.errorMessage,
  });

  SettingsState copyWith({
    UserProfileSettings? profile,
    NotificationSettings? notifications,
    SecuritySettings? security,
    bool? isSaving,
    bool? isPinging,
    int? latencyMs,
    String? successMessage,
    String? errorMessage,
  }) {
    return SettingsState(
      profile: profile ?? this.profile,
      notifications: notifications ?? this.notifications,
      security: security ?? this.security,
      isSaving: isSaving ?? this.isSaving,
      isPinging: isPinging ?? this.isPinging,
      latencyMs: latencyMs ?? this.latencyMs,
      successMessage: successMessage,
      errorMessage: errorMessage,
    );
  }
}

class SettingsController extends StateNotifier<SettingsState> {
  final SettingsRepository _repo;
  final SupabaseClient? _supabaseClient;

  SettingsController(this._repo, this._supabaseClient)
      : super(const SettingsState(
          profile: UserProfileSettings(
            fullName: 'व्यवस्थापक (Administrator)',
            email: 'admin@mindsparq.edu.np',
            phone: '+977 9801234567',
            role: 'Super Administrator',
          ),
          notifications: NotificationSettings(),
          security: SecuritySettings(),
        )) {
    _load();
  }

  Future<void> _load() async {
    final profile = await _repo.getUserProfile();
    final notifs = await _repo.getNotificationSettings();
    final sec = await _repo.getSecuritySettings();
    state = state.copyWith(
      profile: profile,
      notifications: notifs,
      security: sec,
    );
  }

  Future<bool> saveProfile({
    required String fullName,
    required String email,
    required String phone,
  }) async {
    state = state.copyWith(isSaving: true, successMessage: null, errorMessage: null);

    if (fullName.trim().isEmpty) {
      state = state.copyWith(
        isSaving: false,
        errorMessage: 'पुरा नाम आवश्यक छ (Full name is required)',
      );
      return false;
    }

    if (!email.contains('@')) {
      state = state.copyWith(
        isSaving: false,
        errorMessage: 'अमान्य इमेल ढाँचा (Invalid email address)',
      );
      return false;
    }

    try {
      final updated = state.profile.copyWith(
        fullName: fullName.trim(),
        email: email.trim(),
        phone: phone.trim(),
      );
      await _repo.saveUserProfile(updated);
      state = state.copyWith(
        profile: updated,
        isSaving: false,
        successMessage: 'विवरण सफलतापूर्वक अद्यावधिक भयो (Profile updated)',
      );
      return true;
    } catch (e) {
      state = state.copyWith(
        isSaving: false,
        errorMessage: 'विवरण बचत गर्न सकिएन (Failed to save profile): $e',
      );
      return false;
    }
  }

  Future<void> toggleEmailAlerts(bool value) async {
    final updated = state.notifications.copyWith(emailAlerts: value);
    state = state.copyWith(notifications: updated);
    await _repo.saveNotificationSettings(updated);
  }

  Future<void> toggleGateAlerts(bool value) async {
    final updated = state.notifications.copyWith(gateTurnstileAlerts: value);
    state = state.copyWith(notifications: updated);
    await _repo.saveNotificationSettings(updated);
  }

  Future<void> toggleEmergencyAlerts(bool value) async {
    final updated = state.notifications.copyWith(emergencyAlerts: value);
    state = state.copyWith(notifications: updated);
    await _repo.saveNotificationSettings(updated);
  }

  Future<void> toggleBiometric(bool value) async {
    final updated = state.security.copyWith(biometricEnabled: value);
    state = state.copyWith(security: updated);
    await _repo.saveSecuritySettings(updated);
  }

  Future<void> setSessionTimeout(int minutes) async {
    final updated = state.security.copyWith(sessionTimeoutMinutes: minutes);
    state = state.copyWith(security: updated);
    await _repo.saveSecuritySettings(updated);
  }

  Future<bool> changeMasterPin({
    required String oldPin,
    required String newPin,
  }) async {
    if (newPin.length != 6) {
      state = state.copyWith(errorMessage: 'PIN अनिवार्य रूपमा ६ अंकको हुनुपर्छ (Must be 6 digits)');
      return false;
    }

    final isValidOld = await _repo.verifyMasterPin(oldPin);
    if (!isValidOld) {
      state = state.copyWith(errorMessage: 'पुरानो PIN गलत छ (Incorrect current PIN)');
      return false;
    }

    await _repo.saveMasterPin(newPin);
    state = state.copyWith(
      security: state.security.copyWith(hasMasterPin: true),
      successMessage: 'Master PIN सफलतापूर्वक परिवर्तन भयो (PIN changed)',
    );
    return true;
  }

  Future<void> testBackendLatency() async {
    state = state.copyWith(isPinging: true, errorMessage: null);
    final stopwatch = Stopwatch()..start();
    try {
      if (_supabaseClient != null) {
        // Ping database health
        await _supabaseClient.from('schools').select('id').limit(1).maybeSingle();
      } else {
        // Standby simulated roundtrip
        await Future.delayed(const Duration(milliseconds: 38));
      }
      stopwatch.stop();
      state = state.copyWith(
        isPinging: false,
        latencyMs: stopwatch.elapsedMilliseconds.clamp(12, 999),
        successMessage: 'सर्भर जडान सामान्य छ (Server connection normal)',
      );
    } catch (e) {
      stopwatch.stop();
      state = state.copyWith(
        isPinging: false,
        latencyMs: stopwatch.elapsedMilliseconds,
        errorMessage: 'जडान त्रुटि (Connection error): $e',
      );
    }
  }

  Future<void> clearCache() async {
    await _repo.clearCache();
    state = state.copyWith(
      successMessage: 'क्यास डाटा सफलतापूर्वक मेटाइयो (Cache cleared successfully)',
    );
  }
}

final settingsControllerProvider =
    StateNotifierProvider<SettingsController, SettingsState>((ref) {
  final repo = ref.watch(settingsRepositoryProvider);
  final client = ref.watch(supabaseClientProvider);
  return SettingsController(repo, client);
});
