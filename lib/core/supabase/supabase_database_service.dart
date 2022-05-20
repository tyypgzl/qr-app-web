import 'dart:developer';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../constants/app_constants.dart';
import '../exception/postgrest_exception.dart';

class SupabaseDatabaseService {
  final _supabaseClient = SupabaseClient(
      AppConstants.instance.supabaseURL, AppConstants.instance.supabaseAnonKey);

  Future<PostgrestResponse<dynamic>> insert(
      {required String table, required dynamic values}) async {
    try {
      var response = await _supabaseClient.from(table).insert(values).execute();

      return response;
    } on PostgrestError catch (error) {
      log(error.toString());
      throw PostgrestException(error);
    }
  }
}
