class SchoolSummary {
  final String id;
  final String name;
  final DateTime dateAdded;
  final int activePrograms;
  final String status; // 'active', 'pending_setup', 'inactive'

  const SchoolSummary({
    required this.id,
    required this.name,
    required this.dateAdded,
    required this.activePrograms,
    required this.status,
  });

  factory SchoolSummary.fromJson(Map<String, dynamic> json) {
    return SchoolSummary(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? 'Unnamed School',
      dateAdded: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'] as String) ?? DateTime.now()
          : DateTime.now(),
      activePrograms: (json['active_programs'] as num?)?.toInt() ?? 0,
      status: json['status'] as String? ?? 'active',
    );
  }
}
