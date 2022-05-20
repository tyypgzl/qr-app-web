import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:web_app/core/base/base_view.dart';
import 'package:web_app/feature/auth/login/view_model/login_view_model.dart';
import 'package:web_app/feature/shared/utils/app_colors.dart';
import 'package:web_app/feature/shared/widgets/auth_text_field.dart';
import 'package:web_app/feature/shared/widgets/custom_button.dart';

class LoginView extends BaseView<LoginViewModel> {
  LoginView({Key? key}) : super(key: key);

  @override
  LoginViewModel get viewModel => LoginViewModel();

  @override
  Color? get backgroundColor => Colors.white;

  @override
  Widget? body(BuildContext context, LoginViewModel viewModel) {
    return Form(
      key: viewModel.formGlobalKey,
      child: Row(
        children: [
          const Spacer(
            flex: 10,
          ),
          Expanded(
            flex: 40,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/login.png'),
                ),
              ),
              child: Center(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Text(
                    '  Giriş Yap',
                    style: TextStyle(
                        color: AppColors.instance.black,
                        fontSize: 48,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
          const Spacer(
            flex: 10,
          ),
          Expanded(
            flex: 45,
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * .6,
                  height: MediaQuery.of(context).size.height * .97,
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.instance.orangeAccent,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(50),
                      bottomLeft: Radius.circular(50),
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: screenSize.height * .05),
                      Lottie.asset(
                        'assets/animations/login_anim.json',
                        height: MediaQuery.of(context).size.height * .33,
                      ),
                      SizedBox(height: screenSize.height * .1),
                      Expanded(
                        child: Column(
                          children: [
                            AuthTextField(
                              validator: viewModel.mailValidation,
                              onChanged: (value) => viewModel.email = value,
                              labelText: 'E-posta',
                              keyboardType: TextInputType.emailAddress,
                              size: Size(screenSize.width * .97,
                                  screenSize.height * .11),
                            ),
                            AuthTextField(
                              validator: viewModel.passwordValidation,
                              onChanged: (value) => viewModel.password = value,
                              labelText: 'Şifre',
                              keyboardType: TextInputType.visiblePassword,
                              isPassword: true,
                              size: Size(screenSize.width * .97,
                                  screenSize.height * .11),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 16),
                                child: TextButton(
                                  style: ButtonStyle(
                                    padding: MaterialStateProperty.all(
                                        EdgeInsets.zero),
                                  ),
                                  onPressed: () =>
                                      viewModel.forgotPasswordOnTap(context),
                                  child: Text(
                                    'Şifremi unuttum?',
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: AppColors.instance.black),
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                              ),
                            ),
                            CustomButton(
                              onTap: () => viewModel.loginOnTap(context),
                              backgroundColor: AppColors.instance.pink,
                              foregroundColor: AppColors.instance.white,
                              height: MediaQuery.of(context).size.height * .085,
                              width: MediaQuery.of(context).size.width * .4,
                              title: 'Giriş Yap',
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('''Hesabınız yok mu?'''),
                                TextButton(
                                  onPressed: viewModel.registerOnTap,
                                  child: const Text('Kayıt Ol',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800)),
                                  style: ButtonStyle(
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                            AppColors.instance.black),
                                    padding: MaterialStateProperty.all<
                                        EdgeInsetsGeometry>(EdgeInsets.zero),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
