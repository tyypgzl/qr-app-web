import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:web_app/core/base/base_view_model.dart';
import 'package:web_app/core/constants/route_constants.dart';
import 'package:web_app/core/crypto/crypto_manager.dart';
import 'package:web_app/core/enum/page_state_enum.dart';
import 'package:web_app/core/mixin/validation_mixin.dart';
import 'package:web_app/core/navigation/navigation_service.dart';
import 'package:web_app/core/supabase/supabase_auth_service.dart';
import 'package:web_app/core/utils/show_snack_bar.dart';
import 'package:web_app/feature/auth/register/model/user.dart';
import 'package:web_app/feature/create/model/created_lesson.dart';

import '../../../shared/utils/app_colors.dart';
import '../../../shared/widgets/auth_text_field.dart';
import '../../../shared/widgets/custom_button.dart';

class LoginViewModel extends BaseViewModel with ValidationMixin {
  final supabaseAuthService = SupabaseAuthService();

  final client = GetIt.instance<SupabaseClient>();

  final formGlobalKey = GlobalKey<FormState>();
  final forgotPasswordKey = GlobalKey<FormState>();

  String? forgotMail;
  String? email;
  String? password;

  bool isPasswordVisible = true;

  @override
  Future<bool> customBack() {
    navigationService.pop();
    return Future.value(true);
  }

  @override
  Future<void> init() async {
    await Future.delayed(const Duration(milliseconds: 1));
  }

  @override
  NavigationService get navigationService => NavigationService.instance;

  void changePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    notifyListeners();
  }

  Future<void> loginOnTap(BuildContext context) async {
    state = PageState.LOADING;

    if (formGlobalKey.currentState!.validate()) {
      formGlobalKey.currentState!.save();
      var responseDatabase =
          await client.from('user').select().eq('email', email).execute();
      var list = (responseDatabase.data as List<dynamic>);
      var userList = list.map((e) => UserModel.fromJson(e)).toList();
      var name = userList.first.name;
      var surName = userList.first.surname;

      var lesson = Lesson(name: '', teacherName: name, teacherSurname: surName);

      var encryptedPassword = CryptoManager.encryptData(data: password!);
      var response = await supabaseAuthService.login(
          email: email, password: encryptedPassword);
      if (response.statusCode == 200) {
        await navigationService.pushNamedAndRemoveUntil(
            routePath: RouteConstants.create, args: lesson);
      } else {
        showSnackBar(
            context: context,
            content: Text(response.error?.message ?? ''),
            isError: true);
      }
    }

    state = PageState.LOADED;
  }

  void registerOnTap() {
    navigationService.pushNamedAndRemoveUntil(
        routePath: RouteConstants.register);
  }

  Future<void> forgotPasswordOnTap(BuildContext context) async {
    await _forgotPasswordDialog(context);
  }

  Future<void> _forgotPasswordDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Şifremi Unuttum'),
          content: Form(
            key: forgotPasswordKey,
            child: AuthTextField(
              keyboardType: TextInputType.emailAddress,
              labelText: 'E-posta',
              onChanged: (String? value) {
                forgotMail = value;
                notifyListeners();
                return forgotMail;
              },
              size: Size(MediaQuery.of(context).size.width * .3,
                  MediaQuery.of(context).size.height * .08),
              validator: forgotMailValidation,
            ),
          ),
          alignment: Alignment.center,
          actionsPadding:
              const EdgeInsets.only(bottom: 12, left: 12, right: 12),
          contentPadding: const EdgeInsets.only(top: 24, left: 24, right: 24),
          actions: [
            CustomButton(
              title: 'Gönder',
              backgroundColor: AppColors.instance.pink,
              foregroundColor: AppColors.instance.black,
              width: MediaQuery.of(context).size.width * .3,
              height: MediaQuery.of(context).size.height * .06,
              onTap: () async {
                if (forgotPasswordKey.currentState!.validate()) {
                  forgotPasswordKey.currentState!.save();
                  FocusManager.instance.primaryFocus?.nextFocus();
                  var response =
                      await supabaseAuthService.forgotPassword(forgotMail!);
                  navigationService.pop();

                  if (response.statusCode == 200) {
                    showSnackBar(
                      context: context,
                      content: Text(
                        '''Şifre sıfırlama adresi mail adresinize iletilmiştir.''',
                        style: TextStyle(
                            color: AppColors.instance.black, fontSize: 16),
                      ),
                      isError: false,
                    );
                  } else {
                    showSnackBar(
                      context: context,
                      content: Text('''Bir hata oluştu.''',
                          style: TextStyle(
                              color: AppColors.instance.black, fontSize: 16)),
                      isError: false,
                    );
                    log('Error: ${response.error!.message} Code: ${response.error!.statusCode}');
                  }
                }
              },
            ),
          ],
        );
      },
    );
  }

  String? mailValidation(String? value) {
    if (email != null) {
      if (isEmailValid(value!)) {
        return null;
      } else {
        return 'Geçerli bir e-posta adresi giriniz.';
      }
    } else {
      return 'E-posta alanı boş geçilemez.';
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
      return 'Şifre alanı boş geçilemez.';
    }
  }

  String? forgotMailValidation(String? value) {
    if (forgotMail != null) {
      if (isEmailValid(value!)) {
        return null;
      } else {
        return 'Geçerli bir e-posta adresi giriniz.';
      }
    } else {
      return 'E-posta alanı boş geçilemez.';
    }
  }
}
