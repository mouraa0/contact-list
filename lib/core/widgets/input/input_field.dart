import 'package:contact_list/core/constants/app_constants.dart';
import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String hintText;
  final String headerText;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final bool isPassword;

  const InputField({
    super.key,
    this.hintText = '',
    this.validator,
    this.controller,
    this.isPassword = false,
    required this.headerText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            headerText,
            style: TextStyle(
              fontSize: AppConstants.headingSmallerFontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        TextFormField(
          controller: controller,
          obscureText: isPassword,
          decoration: InputDecoration(
            hintText: hintText,
            filled: true,
            fillColor: Theme.of(context).inputDecorationTheme.fillColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(color: Colors.transparent),
            ),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 14.0,
              horizontal: 12.0,
            ),
          ),
          validator: validator,
        ),
      ],
    );
  }
}
