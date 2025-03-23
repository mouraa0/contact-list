import 'package:contact_list/core/constants/app_constants.dart';
import 'package:flutter/material.dart';

enum ButtonType { primary, secondary, error }

class Button extends StatelessWidget {
  final String text;
  final ButtonType type;
  final bool loading;
  final bool disabled;
  final void Function() onPressed;

  const Button({
    super.key,
    required this.text,
    required this.onPressed,
    this.loading = false,
    this.disabled = false,
    this.type = ButtonType.primary,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonBackgroundColor(type, context),
        side: BorderSide(
          color: Theme.of(context).colorScheme.secondary,
          width: 1,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        ),
        elevation: 0,
      ),
      onPressed: !disabled && !loading ? () => onPressed() : null,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
        child:
            loading
                ? SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor,
                  ),
                )
                : Text(
                  text.toUpperCase(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: buttonTextColor(type, context),
                  ),
                ),
      ),
    );
  }
}

Color buttonBackgroundColor(ButtonType buttonType, BuildContext context) {
  switch (buttonType) {
    case ButtonType.primary:
      return Theme.of(context).colorScheme.surface;
    case ButtonType.secondary:
      return Theme.of(context).colorScheme.secondary;
    case ButtonType.error:
      return Theme.of(context).colorScheme.error;
  }
}

Color buttonTextColor(ButtonType buttonType, BuildContext context) {
  switch (buttonType) {
    case ButtonType.primary:
      return Theme.of(context).colorScheme.onSurface;
    case ButtonType.secondary:
      return Theme.of(context).colorScheme.onSecondary;
    case ButtonType.error:
      return Theme.of(context).colorScheme.onError;
  }
}
