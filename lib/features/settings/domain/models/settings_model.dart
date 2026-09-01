import 'package:flutter/foundation.dart';

@immutable
class UserProfileSettings {
  final String fullName;
  final String email;
  final String phone;
  final String role;

  const UserProfileSettings({
    required this.fullName,
    required this.email,
    required this.phone,
    required this.role,
  });

  UserProfileSettings copyWith({
    String? fullName,
    String? email,
    String? phone,
    String? role,
  }) {
    return UserProfileSettings(
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      role: role ?? this.role,
    );
  }

  Map<String, dynamic> toJson() => {
        'full_name': fullName,
        'email': email,
        'phone': phone,
        'role': role,
      };

  factory UserProfileSettings.fromJson(Map<String, dynamic> json) {
    return UserProfileSettings(
      fullName: json['full_name'] as String? ?? 'व्यवस्थापक (Administrator)',
      email: json['email'] as String? ?? 'admin@mindsparq.edu.np',
      phone: json['phone'] as String? ?? '+977 9801234567',
      role: json['role'] as String? ?? 'Super Administrator',
    );
  }
}

@immutable
class NotificationSettings {
  final bool emailAlerts;
  final bool gateTurnstileAlerts;
  final bool emergencyAlerts;

  const NotificationSettings({
    this.emailAlerts = true,
    this.gateTurnstileAlerts = true,
    this.emergencyAlerts = true,
  });

  NotificationSettings copyWith({
    bool? emailAlerts,
    bool? gateTurnstileAlerts,
    bool? emergencyAlerts,
  }) {
    return NotificationSettings(
      emailAlerts: emailAlerts ?? this.emailAlerts,
      gateTurnstileAlerts: gateTurnstileAlerts ?? this.gateTurnstileAlerts,
      emergencyAlerts: emergencyAlerts ?? this.emergencyAlerts,
    );
  }
}

@immutable
class SecuritySettings {
  final bool biometricEnabled;
  final int sessionTimeoutMinutes;
  final bool hasMasterPin;

  const SecuritySettings({
    this.biometricEnabled = false,
    this.sessionTimeoutMinutes = 30,
    this.hasMasterPin = true,
  });

  SecuritySettings copyWith({
    bool? biometricEnabled,
    int? sessionTimeoutMinutes,
    bool? hasMasterPin,
  }) {
    return SecuritySettings(
      biometricEnabled: biometricEnabled ?? this.biometricEnabled,
      sessionTimeoutMinutes: sessionTimeoutMinutes ?? this.sessionTimeoutMinutes,
      hasMasterPin: hasMasterPin ?? this.hasMasterPin,
    );
  }
}
