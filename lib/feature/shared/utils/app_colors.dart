import 'package:flutter/material.dart';

class AppColors {
  static AppColors? _instance;

  static AppColors get instance => _instance ??= AppColors._init();

  AppColors._init();

  Color orangeAccent = const Color(0xffffc170);
  Color orange = const Color(0xfffc9942);
  Color pink = const Color(0xffff636e);
  Color white = const Color(0xfff2f6fc);
  Color black = const Color(0xff000000);
}
