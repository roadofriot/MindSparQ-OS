import 'package:flutter_riverpod/flutter_riverpod.dart';

enum UserRole {
  superAdmin,
  schoolAdmin,
  teacher,
  viewer,
}

enum SensitiveField {
  panNumber,
  bankAccount,
  salary,
}

class RolePermissions {
  final UserRole role;
  final String? currentUserId;

  const RolePermissions({
    this.role = UserRole.superAdmin,
    this.currentUserId,
  });

  bool canViewSensitiveField(SensitiveField field, {String? targetTeacherId}) {
    // SuperAdmin has full access to all fields
    if (role == UserRole.superAdmin) {
      return true;
    }

    // Teacher can view their own PAN and Bank details, but not salary structure of others
    if (role == UserRole.teacher && currentUserId != null && currentUserId == targetTeacherId) {
      if (field == SensitiveField.panNumber || field == SensitiveField.bankAccount) {
        return true;
      }
    }

    // School admin can view PAN, but not salary or unmasked bank account
    if (role == UserRole.schoolAdmin && field == SensitiveField.panNumber) {
      return true;
    }

    return false;
  }

  String maskValue(String? raw, SensitiveField field, {String? targetTeacherId}) {
    if (raw == null || raw.isEmpty) return '—';

    if (canViewSensitiveField(field, targetTeacherId: targetTeacherId)) {
      return raw;
    }

    switch (field) {
      case SensitiveField.panNumber:
        if (raw.length <= 4) return '••••';
        return '•••• ${raw.substring(raw.length - 4)}';
      case SensitiveField.bankAccount:
        if (raw.length <= 4) return '•••• •••• ••••';
        return '•••• •••• •••• ${raw.substring(raw.length - 4)}';
      case SensitiveField.salary:
        return '🔒 Restricted Access';
    }
  }
}

final userRoleProvider = StateProvider<UserRole>((ref) => UserRole.superAdmin);

final rolePermissionsProvider = Provider<RolePermissions>((ref) {
  final role = ref.watch(userRoleProvider);
  return RolePermissions(role: role);
});
