import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final Color backgroundColor;
  final Color foregroundColor;
  final double? width;
  final double? height;
  const CustomButton({
    Key? key,
    required this.onTap,
    required this.title,
    required this.backgroundColor,
    required this.foregroundColor,
    this.height,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(backgroundColor),
          fixedSize: MaterialStateProperty.all<Size>(
            Size(
              width ?? MediaQuery.of(context).size.width * .9,
              height ?? MediaQuery.of(context).size.height * .06,
            ),
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(28),
              ),
            ),
          ),
          elevation: MaterialStateProperty.all<double>(6),
        ),
        onPressed: onTap,
        child: Text(
          title,
          style: TextStyle(color: foregroundColor, fontSize: 16),
        ),
      ),
    );
  }
}
