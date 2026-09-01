import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Production environment configuration manager.
/// Loads values safely from compile-time arguments or local .env file.
class EnvConfig {
  static Future<void> initialize() async {
    try {
      await dotenv.load(fileName: '.env');
    } catch (_) {
      // .env is optional when values are supplied via --dart-define
    }
  }

  static String get supabaseUrl {
    const fromDefine = String.fromEnvironment('SUPABASE_URL');
    if (fromDefine.isNotEmpty) return fromDefine;
    if (!dotenv.isInitialized) return '';
    return dotenv.env['SUPABASE_URL'] ?? '';
  }

  static String get supabaseAnonKey {
    const fromDefine = String.fromEnvironment('SUPABASE_ANON_KEY');
    if (fromDefine.isNotEmpty) return fromDefine;
    if (!dotenv.isInitialized) return '';
    return dotenv.env['SUPABASE_ANON_KEY'] ?? '';
  }

  static String get appEnvironment {
    const fromDefine = String.fromEnvironment('APP_ENV');
    if (fromDefine.isNotEmpty) return fromDefine;
    if (!dotenv.isInitialized) return 'production';
    return dotenv.env['APP_ENV'] ?? 'production';
  }

  static bool get isConfigured =>
      supabaseUrl.isNotEmpty && supabaseAnonKey.isNotEmpty;
}
