import 'teacher_assignment.dart';

class Teacher {
  final String id;
  final String fullName;
  final String fullNameNepali;
  final String designation;
  final int experienceYears;
  final String? avatarUrl;
  final String email;
  final String phone;
  final String address;
  final double overallRating;
  final double attendanceRate;
  final int activeSchoolsCount;
  final String status; // 'active', 'on_leave', 'inactive'

  // Sensitive information protected by role permissions
  final String? panNumber;
  final String? bankName;
  final String? bankAccountNumber;
  final double? baseSalary;
  final String salaryCurrency;

  // Associated assignments
  final List<AssignedSchool> assignedSchools;
  final List<AssignedProgram> assignedPrograms;
  final List<TeacherScheduleItem> schedules;
  final List<TeacherAttendanceRecord> attendanceLogs;
  final List<TeacherTrainingRecord> trainings;
  final List<TeacherDocumentRecord> documents;

  const Teacher({
    required this.id,
    required this.fullName,
    this.fullNameNepali = '',
    required this.designation,
    this.experienceYears = 0,
    this.avatarUrl,
    required this.email,
    required this.phone,
    required this.address,
    this.overallRating = 0.0,
    this.attendanceRate = 0.0,
    this.activeSchoolsCount = 0,
    this.status = 'active',
    this.panNumber,
    this.bankName,
    this.bankAccountNumber,
    this.baseSalary,
    this.salaryCurrency = 'NPR',
    this.assignedSchools = const [],
    this.assignedPrograms = const [],
    this.schedules = const [],
    this.attendanceLogs = const [],
    this.trainings = const [],
    this.documents = const [],
  });

  factory Teacher.fromJson(Map<String, dynamic> json) {
    return Teacher(
      id: json['id'] as String? ?? '',
      fullName: json['full_name'] as String? ?? 'Unnamed Teacher',
      fullNameNepali: json['full_name_nepali'] as String? ?? '',
      designation: json['designation'] as String? ?? 'Instructor',
      experienceYears: (json['experience_years'] as num?)?.toInt() ?? 0,
      avatarUrl: json['avatar_url'] as String?,
      email: json['email'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      address: json['address'] as String? ?? '',
      overallRating: (json['overall_rating'] as num?)?.toDouble() ?? 0.0,
      attendanceRate: (json['attendance_rate'] as num?)?.toDouble() ?? 0.0,
      activeSchoolsCount: (json['active_schools_count'] as num?)?.toInt() ?? 0,
      status: json['status'] as String? ?? 'active',
      panNumber: json['pan_number'] as String?,
      bankName: json['bank_name'] as String?,
      bankAccountNumber: json['bank_account_number'] as String?,
      baseSalary: (json['base_salary'] as num?)?.toDouble(),
      salaryCurrency: json['salary_currency'] as String? ?? 'NPR',
      assignedSchools: (json['assigned_schools'] as List<dynamic>?)
              ?.map((e) => AssignedSchool.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      assignedPrograms: (json['assigned_programs'] as List<dynamic>?)
              ?.map((e) => AssignedProgram.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      schedules: (json['schedules'] as List<dynamic>?)
              ?.map((e) => TeacherScheduleItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      attendanceLogs: (json['attendance_logs'] as List<dynamic>?)
              ?.map((e) => TeacherAttendanceRecord.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      trainings: (json['trainings'] as List<dynamic>?)
              ?.map((e) => TeacherTrainingRecord.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      documents: (json['documents'] as List<dynamic>?)
              ?.map((e) => TeacherDocumentRecord.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );
  }
}
