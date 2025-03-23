import 'package:contact_list/core/widgets/buttons/button.dart';
import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final String text;
  final bool disabled;
  final GlobalKey<FormState> _formKey;
  final void Function() onSubmit;

  const SubmitButton({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.text,
    required this.onSubmit,
    this.disabled = false,
  }) : _formKey = formKey;

  @override
  Widget build(BuildContext context) {
    return Button(
      disabled: disabled,
      text: text,
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          onSubmit();
        }
      },
    );
  }
}
