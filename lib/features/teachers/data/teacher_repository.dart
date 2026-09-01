import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/network/supabase_client_provider.dart';
import '../domain/models/teacher.dart';

abstract class TeacherRepository {
  Future<List<Teacher>> getTeachers({String? query, String? schoolId});
  Future<Teacher?> getTeacherById(String id);
}

class SupabaseTeacherRepository implements TeacherRepository {
  final SupabaseClient? _client;

  SupabaseTeacherRepository(this._client);

  @override
  Future<List<Teacher>> getTeachers({String? query, String? schoolId}) async {
    if (_client == null) return [];

    try {
      var queryBuilder = _client.from('teachers').select();

      if (query != null && query.trim().isNotEmpty) {
        queryBuilder = queryBuilder.ilike('full_name', '%${query.trim()}%');
      }

      final response = await queryBuilder.order('full_name', ascending: true);
      final list = response as List<dynamic>;

      return list
          .map((item) => Teacher.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (_) {
      // Table may not exist yet or connection offline
      return [];
    }
  }

  @override
  Future<Teacher?> getTeacherById(String id) async {
    if (_client == null) return null;

    try {
      final response = await _client
          .from('teachers')
          .select()
          .eq('id', id)
          .maybeSingle();

      if (response == null) return null;

      return Teacher.fromJson(response);
    } catch (_) {
      return null;
    }
  }
}

final teacherRepositoryProvider = Provider<TeacherRepository>((ref) {
  final client = ref.watch(supabaseClientProvider);
  return SupabaseTeacherRepository(client);
});
