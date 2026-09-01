import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../config/env_config.dart';

/// Provider exposing the production SupabaseClient instance.
final supabaseClientProvider = Provider<SupabaseClient?>((ref) {
  if (!EnvConfig.isConfigured) {
    return null;
  }
  try {
    return Supabase.instance.client;
  } catch (_) {
    return null;
  }
});

/// State indicator for Supabase backend connectivity.
final backendConnectionStatusProvider = Provider<bool>((ref) {
  final client = ref.watch(supabaseClientProvider);
  return client != null;
});
