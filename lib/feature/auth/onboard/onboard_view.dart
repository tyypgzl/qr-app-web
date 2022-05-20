import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:web_app/core/base/base_view.dart';
import 'package:web_app/core/constants/route_constants.dart';
import 'package:web_app/core/navigation/navigation_service.dart';
import 'package:web_app/feature/auth/onboard/onboard_view_model.dart';
import 'package:web_app/feature/shared/utils/app_colors.dart';
import 'package:web_app/feature/shared/widgets/custom_button.dart';

class OnboardView extends BaseView<OnboardViewModel> {
  OnboardView({Key? key}) : super(key: key);

  @override
  Widget body(BuildContext context, OnboardViewModel viewModel) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          const Spacer(
            flex: 10,
          ),
          Expanded(
            flex: 40,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/ic_qr.png',
                    width: 250,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Text(
                    'Hoşgeldin',
                    style: Theme.of(context).textTheme.headline3?.copyWith(
                        color: Colors.black, fontWeight: FontWeight.w700),
                  ),
                ],
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
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    color: AppColors.instance.orangeAccent,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(50),
                      bottomLeft: Radius.circular(50),
                    ),
                  ),
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .05,
                      ),
                      Lottie.asset(
                        'assets/animations/login_anim.json',
                        height: MediaQuery.of(context).size.height * .55,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .12,
                      ),
                      CustomButton(
                        onTap: () async {
                          await NavigationService.instance
                              .pushNamed(routePath: RouteConstants.login);
                        },
                        backgroundColor: AppColors.instance.pink,
                        foregroundColor: AppColors.instance.white,
                        title: 'Giriş Yap',
                        height: MediaQuery.of(context).size.height * .08,
                        width: MediaQuery.of(context).size.width * .4,
                      ),
                      CustomButton(
                        onTap: () async {
                          await NavigationService.instance
                              .pushNamed(routePath: RouteConstants.register);
                        },
                        backgroundColor: AppColors.instance.pink,
                        foregroundColor: AppColors.instance.white,
                        title: 'Kayıt Ol',
                        height: MediaQuery.of(context).size.height * .08,
                        width: MediaQuery.of(context).size.width * .4,
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

  @override
  get viewModel => OnboardViewModel();
}


/* 

 Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Expanded(
                    flex: 6,
                    child: Image.asset(
                      'assets/images/ic_qr.png',
                      width: 250,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Welcome',
                      style: Theme.of(context).textTheme.headline3?.copyWith(
                          color: Colors.black, fontWeight: FontWeight.w700),
                    ),
                  ),
                  const Spacer(flex: 7),
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  const Spacer(
                    flex: 4,
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: AppColors.instance.orangeAccent,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomButton(
                            onTap: () async {
                              await NavigationService.instance
                                  .pushNamed(routePath: RouteConstants.login);
                            },
                            backgroundColor: AppColors.instance.pink,
                            foregroundColor: AppColors.instance.white,
                            title: 'Login',
                            height: MediaQuery.of(context).size.height * .067,
                            width: MediaQuery.of(context).size.width * .85,
                          ),
                          CustomButton(
                            onTap: () async {
                              await NavigationService.instance.pushNamed(
                                  routePath: RouteConstants.register);
                            },
                            backgroundColor: AppColors.instance.pink,
                            foregroundColor: AppColors.instance.white,
                            title: 'Register',
                            height: MediaQuery.of(context).size.height * .067,
                            width: MediaQuery.of(context).size.width * .85,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

 */