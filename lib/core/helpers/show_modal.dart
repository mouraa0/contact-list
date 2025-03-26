import 'package:contact_list/core/constants/app_constants.dart';
import 'package:flutter/material.dart';

void showFormModal(BuildContext context, Widget child) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 500),
          child: child,
        ),
      );
    },
  );
}
