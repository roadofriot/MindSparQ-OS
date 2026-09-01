import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/network/supabase_client_provider.dart';

abstract class AuthRepository {
  Future<AuthResponse?> signInWithPassword({
    required String email,
    required String password,
  });

  Future<void> signOut();

  User? get currentUser;

  Stream<AuthState> get authStateChanges;
}

class SupabaseAuthRepository implements AuthRepository {
  final SupabaseClient? _client;

  SupabaseAuthRepository(this._client);

  @override
  Future<AuthResponse?> signInWithPassword({
    required String email,
    required String password,
  }) async {
    if (_client == null) {
      throw const AuthException(
        'Supabase client is not configured. Please set SUPABASE_URL and SUPABASE_ANON_KEY.',
      );
    }
    return await _client.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> signOut() async {
    await _client?.auth.signOut();
  }

  @override
  User? get currentUser => _client?.auth.currentUser;

  @override
  Stream<AuthState> get authStateChanges {
    if (_client == null) return const Stream.empty();
    return _client.auth.onAuthStateChange;
  }
}

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final client = ref.watch(supabaseClientProvider);
  return SupabaseAuthRepository(client);
});
