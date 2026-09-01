import '../entities/school_entity.dart';

abstract class SchoolRepository {
  Future<List<SchoolEntity>> getSchools();
  Future<SchoolEntity> getSchoolById(String id);
  Future<void> createSchool(SchoolEntity school);
}
