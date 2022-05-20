import 'package:flutter/material.dart';

abstract class INavigationService {
  GlobalKey<NavigatorState> get navigatorKey;

  PageRouteBuilder<T> materialPageRoute<T>(
      {required Widget widget, Object? args});

  void pop<T>({args});
  Future<void> pushNamed<T>({required String routePath, args});
  Future<void> pushNamedAndRemoveUntil({required String routePath, args});
  Future<void> push<T>({required Widget widget});
}
