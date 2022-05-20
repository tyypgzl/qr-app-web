import 'package:flutter/material.dart';
import 'package:web_app/feature/shared/utils/app_colors.dart';

class AuthTextField extends StatefulWidget {
  final String? labelText;
  final TextInputType? keyboardType;
  final Size? size;
  final bool isPassword;
  final String? Function(String? value)? validator;
  final String? Function(String? value)? onChanged;
  final Widget? prefixIcon;
  final Color? prefixIconColor;

  const AuthTextField(
      {Key? key,
      required this.labelText,
      required this.keyboardType,
      this.isPassword = false,
      this.validator,
      this.onChanged,
      this.prefixIcon,
      this.prefixIconColor,
      this.size})
      : super(key: key);

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  bool isVisible = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.size!.height,
      width: widget.size!.width,
      child: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 4, right: 12, left: 12),
        child: TextFormField(
          onChanged: widget.onChanged,
          keyboardType: widget.keyboardType,
          validator: widget.validator,
          obscureText: !widget.isPassword ? false : isVisible,
          cursorColor: AppColors.instance.black,
          decoration: InputDecoration(
            suffixIcon: widget.isPassword
                ? IconButton(
                    padding: EdgeInsets.zero,
                    splashColor: Colors.blue.shade100,
                    onPressed: () {
                      setState(() {
                        isVisible = !isVisible;
                      });
                    },
                    icon: isVisible
                        ? Icon(
                            Icons.visibility_off,
                            color: AppColors.instance.black,
                          )
                        : Icon(
                            Icons.visibility,
                            color: AppColors.instance.pink,
                          ),
                  )
                : null,
            prefixIcon: widget.prefixIcon,
            prefixIconColor: widget.prefixIconColor,
            contentPadding: const EdgeInsets.fromLTRB(16, 8, 12, 8),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.instance.black),
              borderRadius: const BorderRadius.all(
                Radius.circular(24),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.instance.black),
              borderRadius: const BorderRadius.all(
                Radius.circular(24),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.instance.black),
              borderRadius: const BorderRadius.all(
                Radius.circular(24),
              ),
            ),
            labelText: widget.labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            labelStyle: TextStyle(color: AppColors.instance.black),
          ),
        ),
      ),
    );
  }
}
