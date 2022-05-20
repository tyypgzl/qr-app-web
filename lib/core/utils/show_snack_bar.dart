import 'package:flutter/material.dart';
import 'package:web_app/feature/shared/utils/app_colors.dart';

void showSnackBar(
    {required BuildContext context,
    required Widget content,
    required bool isError}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: content,
      backgroundColor:
          isError ? AppColors.instance.pink : AppColors.instance.orangeAccent,
      duration: const Duration(seconds: 1),
    ),
  );
}
