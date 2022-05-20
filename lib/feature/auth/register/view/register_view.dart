import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:web_app/core/base/base_view.dart';
import 'package:web_app/feature/auth/register/view_model/register_view_model.dart';
import 'package:web_app/feature/shared/utils/app_colors.dart';
import 'package:web_app/feature/shared/widgets/auth_text_field.dart';
import 'package:web_app/feature/shared/widgets/custom_button.dart';

class RegisterView extends BaseView<RegisterViewModel> {
  RegisterView({Key? key}) : super(key: key);

  @override
  RegisterViewModel get viewModel => RegisterViewModel();

  @override
  Widget? body(BuildContext context, RegisterViewModel viewModel) => Form(
        key: viewModel.formKey,
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
                      '  Kayıt Ol',
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
                        Lottie.asset(
                          'assets/animations/login_anim.json',
                          height: MediaQuery.of(context).size.height * .33,
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: AuthTextField(
                                      validator: viewModel.nameValidation,
                                      onChanged: (value) =>
                                          viewModel.firstName = value,
                                      labelText: 'Ad',
                                      keyboardType: TextInputType.name,
                                      size: Size(screenSize.width * .2,
                                          screenSize.height * .125),
                                    ),
                                  ),
                                  Expanded(
                                    child: AuthTextField(
                                      validator: viewModel.lastNameValidation,
                                      onChanged: (value) =>
                                          viewModel.lastName = value,
                                      labelText: 'Soyad',
                                      keyboardType: TextInputType.name,
                                      size: Size(screenSize.width * .2,
                                          screenSize.height * .125),
                                    ),
                                  ),
                                ],
                              ),
                              AuthTextField(
                                validator: viewModel.mailValidation,
                                onChanged: (value) => viewModel.email = value,
                                labelText: 'E-posta',
                                keyboardType: TextInputType.emailAddress,
                                size: Size(screenSize.width * .89,
                                    screenSize.height * .125),
                              ),
                              AuthTextField(
                                validator: viewModel.passwordValidation,
                                onChanged: (value) =>
                                    viewModel.password = value,
                                labelText: 'Şifre',
                                keyboardType: TextInputType.visiblePassword,
                                size: Size(screenSize.width * .90,
                                    screenSize.height * .125),
                                isPassword: true,
                              ),
                              SizedBox(
                                height: screenSize.height * .03,
                              ),
                              CustomButton(
                                onTap: () =>
                                    viewModel.registerButtonOnTap(context),
                                title: 'Kayıt Ol',
                                backgroundColor: AppColors.instance.pink,
                                foregroundColor: AppColors.instance.white,
                                height:
                                    MediaQuery.of(context).size.height * .085,
                                width: MediaQuery.of(context).size.width * .4,
                              ),
                              SizedBox(
                                height: screenSize.height * .02,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text('Zaten bir hesabınız var mı? '),
                                  TextButton(
                                    onPressed: viewModel.loginButtonOnTap,
                                    child: const Text(
                                      'Giriş Yap',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800),
                                    ),
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
