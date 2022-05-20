import 'dart:developer';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../exception/go_true_exception.dart';

class SupabaseAuthService {
  final client = GetIt.instance<SupabaseClient>();

  Future<GotrueSessionResponse> login({String? email, String? password}) async {
    try {
      final response =
          await client.auth.signIn(email: email, password: password);

      return response;
    } on GotrueError catch (error) {
      log(error.toString());
      throw GotrueException(error);
    }
  }

  Future<GotrueSessionResponse> register({
    required String email,
    required String password,
  }) async {
    try {
      final response = await client.auth.signUp(email, password);

      return response;
    } on GotrueError catch (error) {
      log(error.toString());
      throw GotrueException(error);
    }
  }

  Future<GotrueResponse> signOut() async {
    try {
      final response = await client.auth.signOut();

      return response;
    } on GotrueError catch (error) {
      log(error.toString());
      throw GotrueException(error);
    }
  }

  Future<GotrueJsonResponse> forgotPassword(String email) async {
    try {
      final response = await client.auth.api.resetPasswordForEmail(email);
      return response;
    } on GotrueError catch (error) {
      log(error.toString());
      throw GotrueException(error);
    }
  }
}
