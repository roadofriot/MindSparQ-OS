class AssignedSchool {
  final String id;
  final String name;
  final String address;
  final bool isPrimary;

  const AssignedSchool({
    required this.id,
    required this.name,
    required this.address,
    this.isPrimary = false,
  });

  factory AssignedSchool.fromJson(Map<String, dynamic> json) {
    return AssignedSchool(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      address: json['address'] as String? ?? '',
      isPrimary: json['is_primary'] as bool? ?? false,
    );
  }
}

class AssignedProgram {
  final String id;
  final String name;
  final String code;
  final String grade;
  final String section;
  final bool isActive;

  const AssignedProgram({
    required this.id,
    required this.name,
    required this.code,
    required this.grade,
    required this.section,
    this.isActive = true,
  });

  factory AssignedProgram.fromJson(Map<String, dynamic> json) {
    return AssignedProgram(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      code: json['code'] as String? ?? 'P',
      grade: json['grade'] as String? ?? '',
      section: json['section'] as String? ?? '',
      isActive: json['is_active'] as bool? ?? true,
    );
  }
}

class TeacherScheduleItem {
  final String dayOfWeek;
  final String startTime;
  final String endTime;
  final String subject;
  final String schoolName;
  final String classroom;

  const TeacherScheduleItem({
    required this.dayOfWeek,
    required this.startTime,
    required this.endTime,
    required this.subject,
    required this.schoolName,
    required this.classroom,
  });

  factory TeacherScheduleItem.fromJson(Map<String, dynamic> json) {
    return TeacherScheduleItem(
      dayOfWeek: json['day_of_week'] as String? ?? '',
      startTime: json['start_time'] as String? ?? '',
      endTime: json['end_time'] as String? ?? '',
      subject: json['subject'] as String? ?? '',
      schoolName: json['school_name'] as String? ?? '',
      classroom: json['classroom'] as String? ?? '',
    );
  }
}

class TeacherAttendanceRecord {
  final DateTime date;
  final String status; // 'present', 'late', 'absent'
  final String? checkInTime;
  final String? checkOutTime;
  final String? location;

  const TeacherAttendanceRecord({
    required this.date,
    required this.status,
    this.checkInTime,
    this.checkOutTime,
    this.location,
  });

  factory TeacherAttendanceRecord.fromJson(Map<String, dynamic> json) {
    return TeacherAttendanceRecord(
      date: json['date'] != null
          ? DateTime.tryParse(json['date'] as String) ?? DateTime.now()
          : DateTime.now(),
      status: json['status'] as String? ?? 'present',
      checkInTime: json['check_in_time'] as String?,
      checkOutTime: json['check_out_time'] as String?,
      location: json['location'] as String?,
    );
  }
}

class TeacherTrainingRecord {
  final String id;
  final String title;
  final String institution;
  final DateTime completedDate;
  final int creditHours;
  final String certificateNumber;

  const TeacherTrainingRecord({
    required this.id,
    required this.title,
    required this.institution,
    required this.completedDate,
    required this.creditHours,
    required this.certificateNumber,
  });

  factory TeacherTrainingRecord.fromJson(Map<String, dynamic> json) {
    return TeacherTrainingRecord(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      institution: json['institution'] as String? ?? '',
      completedDate: json['completed_date'] != null
          ? DateTime.tryParse(json['completed_date'] as String) ?? DateTime.now()
          : DateTime.now(),
      creditHours: (json['credit_hours'] as num?)?.toInt() ?? 0,
      certificateNumber: json['certificate_number'] as String? ?? '',
    );
  }
}

class TeacherDocumentRecord {
  final String id;
  final String title;
  final String documentType; // 'pan', 'bank', 'contract', 'certificate'
  final String? fileUrl;
  final bool isSensitive;

  const TeacherDocumentRecord({
    required this.id,
    required this.title,
    required this.documentType,
    this.fileUrl,
    this.isSensitive = false,
  });

  factory TeacherDocumentRecord.fromJson(Map<String, dynamic> json) {
    return TeacherDocumentRecord(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      documentType: json['document_type'] as String? ?? 'general',
      fileUrl: json['file_url'] as String?,
      isSensitive: json['is_sensitive'] as bool? ?? false,
    );
  }
}
