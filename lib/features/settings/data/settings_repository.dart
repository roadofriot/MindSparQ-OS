import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../domain/models/settings_model.dart';

abstract class SettingsRepository {
  Future<ThemeMode> getThemeMode();
  Future<void> saveThemeMode(ThemeMode mode);

  Future<Locale> getLocale();
  Future<void> saveLocale(Locale locale);

  Future<UserProfileSettings> getUserProfile();
  Future<void> saveUserProfile(UserProfileSettings profile);

  Future<NotificationSettings> getNotificationSettings();
  Future<void> saveNotificationSettings(NotificationSettings settings);

  Future<SecuritySettings> getSecuritySettings();
  Future<void> saveSecuritySettings(SecuritySettings settings);

  Future<bool> verifyMasterPin(String pin);
  Future<void> saveMasterPin(String newPin);

  Future<void> clearCache();
}

class SharedPreferencesSettingsRepository implements SettingsRepository {
  final SharedPreferences? _prefs;

  SharedPreferencesSettingsRepository(this._prefs);

  static const _keyThemeMode = 'ms_settings_theme_mode';
  static const _keyLocale = 'ms_settings_locale';
  static const _keyName = 'ms_settings_user_name';
  static const _keyEmail = 'ms_settings_user_email';
  static const _keyPhone = 'ms_settings_user_phone';
  static const _keyRole = 'ms_settings_user_role';
  static const _keyNotifEmail = 'ms_settings_notif_email';
  static const _keyNotifGate = 'ms_settings_notif_gate';
  static const _keyNotifEmergency = 'ms_settings_notif_emergency';
  static const _keySecBiometric = 'ms_settings_sec_biometric';
  static const _keySecTimeout = 'ms_settings_sec_timeout';
  static const _keySecPin = 'ms_settings_sec_pin';

  @override
  Future<ThemeMode> getThemeMode() async {
    final value = _prefs?.getString(_keyThemeMode);
    switch (value) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      case 'system':
      default:
        return ThemeMode.system;
    }
  }

  @override
  Future<void> saveThemeMode(ThemeMode mode) async {
    await _prefs?.setString(_keyThemeMode, mode.name);
  }

  @override
  Future<Locale> getLocale() async {
    final code = _prefs?.getString(_keyLocale) ?? 'ne';
    return Locale(code);
  }

  @override
  Future<void> saveLocale(Locale locale) async {
    await _prefs?.setString(_keyLocale, locale.languageCode);
  }

  @override
  Future<UserProfileSettings> getUserProfile() async {
    return UserProfileSettings(
      fullName: _prefs?.getString(_keyName) ?? 'व्यवस्थापक (Administrator)',
      email: _prefs?.getString(_keyEmail) ?? 'admin@mindsparq.edu.np',
      phone: _prefs?.getString(_keyPhone) ?? '+977 9801234567',
      role: _prefs?.getString(_keyRole) ?? 'Super Administrator',
    );
  }

  @override
  Future<void> saveUserProfile(UserProfileSettings profile) async {
    await _prefs?.setString(_keyName, profile.fullName);
    await _prefs?.setString(_keyEmail, profile.email);
    await _prefs?.setString(_keyPhone, profile.phone);
    await _prefs?.setString(_keyRole, profile.role);
  }

  @override
  Future<NotificationSettings> getNotificationSettings() async {
    return NotificationSettings(
      emailAlerts: _prefs?.getBool(_keyNotifEmail) ?? true,
      gateTurnstileAlerts: _prefs?.getBool(_keyNotifGate) ?? true,
      emergencyAlerts: _prefs?.getBool(_keyNotifEmergency) ?? true,
    );
  }

  @override
  Future<void> saveNotificationSettings(NotificationSettings settings) async {
    await _prefs?.setBool(_keyNotifEmail, settings.emailAlerts);
    await _prefs?.setBool(_keyNotifGate, settings.gateTurnstileAlerts);
    await _prefs?.setBool(_keyNotifEmergency, settings.emergencyAlerts);
  }

  @override
  Future<SecuritySettings> getSecuritySettings() async {
    return SecuritySettings(
      biometricEnabled: _prefs?.getBool(_keySecBiometric) ?? false,
      sessionTimeoutMinutes: _prefs?.getInt(_keySecTimeout) ?? 30,
      hasMasterPin: _prefs?.getString(_keySecPin) != null,
    );
  }

  @override
  Future<void> saveSecuritySettings(SecuritySettings settings) async {
    await _prefs?.setBool(_keySecBiometric, settings.biometricEnabled);
    await _prefs?.setInt(_keySecTimeout, settings.sessionTimeoutMinutes);
  }

  @override
  Future<bool> verifyMasterPin(String pin) async {
    final stored = _prefs?.getString(_keySecPin) ?? '123456';
    return stored == pin;
  }

  @override
  Future<void> saveMasterPin(String newPin) async {
    await _prefs?.setString(_keySecPin, newPin);
  }

  @override
  Future<void> clearCache() async {
    // Clear only non-identity operational keys
    await _prefs?.remove('ms_cached_schools');
    await _prefs?.remove('ms_cached_teachers');
    await _prefs?.remove('ms_cached_attendance');
  }
}

final sharedPreferencesProvider = Provider<SharedPreferences?>((ref) {
  // Overridden in main/tests or loaded lazily
  return null;
});

final settingsRepositoryProvider = Provider<SettingsRepository>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return SharedPreferencesSettingsRepository(prefs);
});
