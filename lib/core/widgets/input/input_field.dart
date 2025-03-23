import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String hintText;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final bool isPassword;

  const InputField({
    super.key,
    this.hintText = '',
    this.validator,
    this.controller,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: Theme.of(context).inputDecorationTheme.fillColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(
            color: Colors.transparent,
          ),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 14.0, horizontal: 12.0),
      ),
      validator: validator,
    );
  }
}
