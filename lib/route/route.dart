import 'package:flutter/material.dart';
import 'package:web_app/core/constants/route_constants.dart';
import 'package:web_app/core/navigation/navigation_service.dart';
import 'package:web_app/core/widgets/error_view.dart';
import 'package:web_app/feature/auth/login/view/login_view.dart';
import 'package:web_app/feature/auth/onboard/onboard_view.dart';
import 'package:web_app/feature/auth/register/view/register_view.dart';
import 'package:web_app/feature/create/view/create_view.dart';
import 'package:web_app/feature/home/view/home_view.dart';

import '../feature/create/model/created_lesson.dart';

class AppRoute {
  static final NavigationService _navigationService =
      NavigationService.instance;

  static Route generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RouteConstants.onboard:
        return _navigationService.materialPageRoute(widget: OnboardView());

      case RouteConstants.register:
        return _navigationService.materialPageRoute(widget: RegisterView());

      case RouteConstants.login:
        return _navigationService.materialPageRoute(widget: LoginView());

      case RouteConstants.home:
        return _navigationService.materialPageRoute(
            widget: HomeView(lesson: routeSettings.arguments as Lesson));

      case RouteConstants.create:
        return _navigationService.materialPageRoute(
          widget: CreateView(lesson: routeSettings.arguments as Lesson),
        );

      case RouteConstants.error:
        return _navigationService.materialPageRoute(
            widget: NotFoundPage(message: routeSettings.arguments as String));

      default:
        return _navigationService.materialPageRoute(
            widget: const NotFoundPage(message: 'Sayfa Bulunamadı.'));
    }
  }
}
