import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mindsparq_os/core/auth/role_permissions.dart';
import 'package:mindsparq_os/core/design_system/design_system.dart';
import 'package:mindsparq_os/features/teachers/data/teacher_repository.dart';
import 'package:mindsparq_os/features/teachers/domain/models/teacher.dart';
import 'package:mindsparq_os/features/teachers/domain/models/teacher_assignment.dart';
import 'package:mindsparq_os/features/teachers/presentation/screens/teacher_profile_screen.dart';
import 'package:mindsparq_os/features/teachers/presentation/screens/teachers_screen.dart';
import 'package:mindsparq_os/features/teachers/presentation/widgets/document_vault_card.dart';
import 'package:mindsparq_os/features/teachers/presentation/widgets/teacher_card.dart';

class FakeTeacherRepository implements TeacherRepository {
  final List<Teacher> teachers;
  FakeTeacherRepository(this.teachers);

  @override
  Future<List<Teacher>> getTeachers({String? query, String? schoolId}) async {
    if (query != null && query.isNotEmpty) {
      return teachers
          .where((t) => t.fullName.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    return teachers;
  }

  @override
  Future<Teacher?> getTeacherById(String id) async {
    return teachers.where((t) => t.id == id).firstOrNull;
  }
}

final sampleTeacher = Teacher(
  id: 't-101',
  fullName: 'Ram Sharma',
  fullNameNepali: 'राम शर्मा',
  designation: 'Senior Instructor',
  experienceYears: 5,
  email: 'ram.sharma@mindsparq.edu',
  phone: '+977 98765 43210',
  address: '42, Tech Park Avenue, Kathmandu',
  overallRating: 4.8,
  attendanceRate: 0.96,
  activeSchoolsCount: 3,
  panNumber: 'ABCDE1234F',
  bankName: 'Nabil Bank',
  bankAccountNumber: '0123456789012',
  baseSalary: 75000,
  salaryCurrency: 'NPR',
  assignedSchools: const [
    AssignedSchool(
      id: 's-1',
      name: 'Delhi Public School, East',
      address: 'Kathmandu',
      isPrimary: true,
    ),
    AssignedSchool(
      id: 's-2',
      name: 'National Public School',
      address: 'Lalitpur',
    ),
    AssignedSchool(
      id: 's-3',
      name: 'Oakridge International',
      address: 'Bhaktapur',
    ),
  ],
  assignedPrograms: const [
    AssignedProgram(
      id: 'p-1',
      name: 'Abacus Level 1-3',
      code: 'M',
      grade: 'Grade 4-6',
      section: 'A',
    ),
    AssignedProgram(
      id: 'p-2',
      name: 'AI & Coding (Junior)',
      code: 'P',
      grade: 'Grade 7',
      section: 'B',
    ),
  ],
  schedules: const [
    TeacherScheduleItem(
      dayOfWeek: 'Monday',
      startTime: '09:00 AM',
      endTime: '10:00 AM',
      subject: 'Mathematics',
      schoolName: 'Delhi Public School',
      classroom: '101',
    ),
  ],
  attendanceLogs: [
    TeacherAttendanceRecord(
      date: DateTime(2026, 8, 30),
      status: 'present',
      checkInTime: '08:55 AM',
      checkOutTime: '04:05 PM',
    ),
  ],
  trainings: [
    TeacherTrainingRecord(
      id: 'tr-1',
      title: 'Advanced STEM Pedagogy',
      institution: 'MindSparQ Institute',
      completedDate: DateTime(2026, 6, 15),
      creditHours: 40,
      certificateNumber: 'MSP-STEM-2026-08',
    ),
  ],
);

void main() {
  setUpAll(() {
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  group('Teachers Module - Directory & Profile Tests', () {
    testWidgets('Renders Teachers directory empty state when no teachers',
        (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            teacherRepositoryProvider.overrideWithValue(
              FakeTeacherRepository([]),
            ),
          ],
          child: const MaterialApp(
            home: TeachersScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('शिक्षकहरू (Teachers)'), findsOneWidget);
      expect(find.text('No Teachers Found'), findsOneWidget);
      expect(find.byType(AppSearchField), findsOneWidget);
    });

    testWidgets('Renders TeacherCard in directory when teachers exist',
        (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            teacherRepositoryProvider.overrideWithValue(
              FakeTeacherRepository([sampleTeacher]),
            ),
          ],
          child: const MaterialApp(
            home: TeachersScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(TeacherCard), findsOneWidget);
      expect(find.text('Ram Sharma'), findsOneWidget);
      expect(find.text('Senior Instructor • 5 Yrs Exp.'), findsOneWidget);
      expect(find.text('4.8'), findsOneWidget);
      expect(find.text('96%'), findsOneWidget);
    });

    testWidgets(
        'Renders Stitch TeacherProfile elements (Header, Metrics, Tabs, Vault)',
        (tester) async {
      tester.view.physicalSize = const Size(1920, 1080);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            teacherRepositoryProvider.overrideWithValue(
              FakeTeacherRepository([sampleTeacher]),
            ),
          ],
          child: const MaterialApp(
            home: TeacherProfileScreen(teacherId: 't-101'),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Breadcrumb & Header
      expect(find.text('Teachers'), findsOneWidget);
      expect(find.text('Ram Sharma'), findsWidgets);
      expect(find.text('Senior Instructor • 5 Years Exp.'), findsOneWidget);
      expect(find.text('Message'), findsOneWidget);
      expect(find.text('Edit Profile'), findsOneWidget);

      // 3 Metrics
      expect(find.text('OVERALL RATING'), findsOneWidget);
      expect(find.text('4.8 ★'), findsOneWidget);
      expect(find.text('ATTENDANCE RATE'), findsOneWidget);
      expect(find.text('96% ↗'), findsOneWidget);
      expect(find.text('ACTIVE SCHOOLS'), findsOneWidget);
      expect(find.text('3'), findsOneWidget);

      // Tabs
      expect(find.text('Overview'), findsOneWidget);
      expect(find.text('Schools'), findsOneWidget);
      expect(find.text('Schedule'), findsOneWidget);
      expect(find.text('Attendance'), findsOneWidget);
      expect(find.text('Training'), findsOneWidget);

      // Overview Cards
      expect(find.text('Contact Information'), findsOneWidget);
      expect(find.text('ram.sharma@mindsparq.edu'), findsOneWidget);
      expect(find.text('Assignments'), findsOneWidget);
      expect(find.text('Abacus Level 1-3'), findsOneWidget);
      expect(find.text('Delhi Public School, East'), findsOneWidget);
      expect(find.byType(DocumentVaultCard), findsOneWidget);
    });

    testWidgets('Role-Based Security: superAdmin sees unmasked salary',
        (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            teacherRepositoryProvider.overrideWithValue(
              FakeTeacherRepository([sampleTeacher]),
            ),
            userRoleProvider.overrideWith((ref) => UserRole.superAdmin),
          ],
          child: const MaterialApp(
            home: TeacherProfileScreen(teacherId: 't-101'),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // SuperAdmin sees base salary
      expect(find.text('NPR 75000'), findsOneWidget);
    });

    testWidgets('Role-Based Security: viewer sees restricted lock',
        (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            teacherRepositoryProvider.overrideWithValue(
              FakeTeacherRepository([sampleTeacher]),
            ),
            userRoleProvider.overrideWith((ref) => UserRole.viewer),
          ],
          child: const MaterialApp(
            home: TeacherProfileScreen(teacherId: 't-101'),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Viewer sees restricted access and lock icon
      expect(find.text('Restricted Access'), findsOneWidget);
      expect(find.byIcon(Icons.lock_outline), findsOneWidget);
    });
  });
}
