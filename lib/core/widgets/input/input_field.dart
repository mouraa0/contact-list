import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputField extends StatelessWidget {
  final String hintText;
  final IconData? prefix;
  final String headerText;
  final FocusNode? focusNode;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final bool isPassword;
  final List<TextInputFormatter> inputFormatters;
  final void Function(String?)? onChanged;

  const InputField({
    super.key,
    this.hintText = '',
    this.headerText = '',
    this.validator,
    this.controller,
    this.focusNode,
    this.prefix,
    this.isPassword = false,
    this.onChanged,
    this.inputFormatters = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 5,
      children: [
        if (headerText.isNotEmpty)
          Align(alignment: Alignment.centerLeft, child: Text(headerText)),
        TextFormField(
          controller: controller,
          obscureText: isPassword,
          inputFormatters: inputFormatters,
          focusNode: focusNode,
          decoration: InputDecoration(
            hintText: hintText,
            filled: true,
            prefixIcon: prefix != null ? Icon(prefix) : null,
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
          onChanged: onChanged,
          validator: validator,
        ),
      ],
    );
  }
}
