import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/teacher_repository.dart';
import '../../domain/models/teacher.dart';

final teacherSearchQueryProvider = StateProvider<String>((ref) => '');

final teacherListProvider = FutureProvider.autoDispose<List<Teacher>>((ref) async {
  final repository = ref.watch(teacherRepositoryProvider);
  final query = ref.watch(teacherSearchQueryProvider);
  return await repository.getTeachers(query: query);
});

final teacherDetailProvider =
    FutureProvider.autoDispose.family<Teacher?, String>((ref, id) async {
  final repository = ref.watch(teacherRepositoryProvider);
  return await repository.getTeacherById(id);
});
