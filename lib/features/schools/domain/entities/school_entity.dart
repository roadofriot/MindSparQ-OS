class SchoolEntity {
  final String id;
  final String name;
  final String code;
  final String district;
  final int studentCount;
  final String status;
  final DateTime createdAt;

  const SchoolEntity({
    required this.id,
    required this.name,
    required this.code,
    required this.district,
    required this.studentCount,
    required this.status,
    required this.createdAt,
  });
}
