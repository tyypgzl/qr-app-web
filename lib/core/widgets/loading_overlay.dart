import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingOverlay extends StatelessWidget {
  const LoadingOverlay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        color: Colors.black.withOpacity(.5),
        child: Center(
          child: Lottie.asset(
            'assets/animations/loading.json',
            height: 120,
          ),
        ),
      );
}
