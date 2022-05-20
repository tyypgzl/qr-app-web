import 'package:supabase_flutter/supabase_flutter.dart';

class GotrueException implements Exception {
  final GotrueError error;

  GotrueException(this.error);

  @override
  String toString() {
    return 'Mesage: ${error.message} Status Code: ${error.statusCode}';
  }
}
