import 'package:flutter/material.dart';

import 'navigation_interface.dart';

class NavigationService extends INavigationService {
  static NavigationService? _instance;

  static NavigationService get instance =>
      _instance ??= NavigationService._init();

  NavigationService._init();

  @override
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  void pop<T>({args}) {
    navigatorKey.currentState?.pop<T>(args);
  }

  @override
  Future<void> push<T>({required Widget widget}) async {
    await navigatorKey.currentState!.push(materialPageRoute(widget: widget));
  }

  @override
  Future<void> pushNamed<T>({required String routePath, args}) async {
    await navigatorKey.currentState!.pushNamed<T>(routePath, arguments: args);
  }

  @override
  Future<void> pushNamedAndRemoveUntil(
      {required String routePath, args}) async {
    await navigatorKey.currentState!
        .pushNamedAndRemoveUntil(routePath, (route) => false, arguments: args);
  }

  @override
  PageRouteBuilder<T> materialPageRoute<T>(
          {required Widget widget, Object? args}) =>
      PageRouteBuilder(
        transitionsBuilder: (_, animation, __, child) {
          const begin = Offset(1, 0);
          const end = Offset.zero;
          final tween = Tween(end: end, begin: begin);
          final offSetAnimation = animation.drive(tween);
          return SlideTransition(position: offSetAnimation, child: child);
        },
        pageBuilder: (_, __, ___) => widget,
        settings: RouteSettings(arguments: args),
      );
}
