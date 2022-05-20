import 'dart:developer';
import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:web_app/core/base/base_view_model.dart';
import 'package:web_app/core/constants/route_constants.dart';
import 'package:web_app/core/enum/page_state_enum.dart';
import 'package:web_app/core/mixin/validation_mixin.dart';
import 'package:web_app/core/navigation/navigation_service.dart';
import 'package:web_app/core/supabase/supabase_auth_service.dart';
import 'package:web_app/feature/auth/register/model/user.dart';
import '../../../../core/utils/show_snack_bar.dart';

class RegisterViewModel extends BaseViewModel with ValidationMixin {
  SupabaseAuthService supabaseAuthService = SupabaseAuthService();

  final client = GetIt.instance<SupabaseClient>();

  @override
  NavigationService get navigationService => NavigationService.instance;

  @override
  Future<bool> customBack() {
    NavigationService.instance.pop();
    return Future.value(true);
  }

  @override
  Future<void> init() {
    return Future.delayed(const Duration(milliseconds: 100));
  }

  final formKey = GlobalKey<FormState>();

  String? firstName;
  String? lastName;
  String? email;
  String? password;

  bool isPasswordVisible = false;

  void changePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    notifyListeners();
  }

  Future<void> registerButtonOnTap(BuildContext context) async {
    state = PageState.LOADING;

    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      var responseAuth = await supabaseAuthService.register(
          email: email!, password: password!);
      if (responseAuth.statusCode == 200) {
        var responseDatabase =
            await client.from('user').insert(user.toJson()).execute();
        log(responseDatabase.status.toString());
        if (responseDatabase.status == 200) {
          log('User Saved Database');
        }
        await navigationService.pushNamed(routePath: RouteConstants.login);
      } else {
        showSnackBar(
            context: context,
            content: Text(responseAuth.error?.message ?? ''),
            isError: true);
      }
    }
    state = PageState.LOADED;
  }

  UserModel get user => UserModel(
      name: firstName ?? '',
      surname: lastName ?? '',
      email: email ?? '',
      password: password ?? '',
      uuid: 'uuid');

  void loginButtonOnTap() {
    navigationService.pushNamedAndRemoveUntil(routePath: RouteConstants.login);
  }

  String? nameValidation(String? value) {
    if (firstName != null) {
      if (isEmailValid(value!)) {
        return null;
      } else {
        return 'Geçerli bir ad giriniz.';
      }
    } else {
      return 'Geçerli bir ad giriniz.';
    }
  }

  String? lastNameValidation(String? value) {
    if (lastName != null) {
      if (isEmailValid(value!)) {
        return null;
      } else {
        return 'Geçerli bir soyad giriniz.';
      }
    } else {
      return 'Geçerli bir soyad giriniz.';
    }
  }

  String? mailValidation(String? value) {
    if (email != null) {
      if (isEmailValid(value!)) {
        return null;
      } else {
        return 'Geçerli bir e-posta adresi giriniz.';
      }
    } else {
      return 'Geçerli bir e-posta adresi giriniz.';
    }
  }

  String? passwordValidation(String? value) {
    if (password != null) {
      if (isLowPasswordValid(value!)) {
        return null;
      } else {
        return 'Geçerli bir şifre giriniz.';
      }
    } else {
      return 'Geçerli bir şifre giriniz.';
    }
  }
}
