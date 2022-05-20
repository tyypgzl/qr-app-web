import 'package:flutter/material.dart';

class NotFoundPage extends StatelessWidget {
  final String message;
  const NotFoundPage({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.red),
          ),
          body: Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error, color: Colors.red, size: 72),
                const SizedBox(height: 20),
                Text(
                  message,
                  style: Theme.of(context)
                      .textTheme
                      .headline4!
                      .copyWith(color: Colors.red),
                ),
              ],
            ),
          ),
        ),
      );
}
