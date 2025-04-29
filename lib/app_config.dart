import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  static String get backendBaseUrl => dotenv.env['BACKEND_BASE_URL'] ?? 'http://localhost:5000';
}
