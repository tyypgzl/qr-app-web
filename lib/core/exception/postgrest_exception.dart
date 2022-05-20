import 'package:supabase_flutter/supabase_flutter.dart';

class PostgrestException implements Exception {
  final PostgrestError error;

  PostgrestException(this.error);

  @override
  String toString() {
    return 'Mesage: ${error.message} Status Code: ${error.code}';
  }
}
