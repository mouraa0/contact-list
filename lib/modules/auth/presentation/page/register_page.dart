import 'package:contact_list/core/constants/app_constants.dart';
import 'package:contact_list/modules/auth/presentation/controllers/register_controller.dart';
import 'package:contact_list/modules/auth/presentation/page/components/auth_form.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  final RegisterController controller;

  const RegisterPage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 400,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppConstants.borderRadius),
            border: Border.all(
              color: Theme.of(context).colorScheme.secondary,
              width: 1,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              top: AppConstants.defaultPadding,
              bottom: AppConstants.defaultPadding,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.location_on_outlined,
                  size: 80.0,
                  color: Theme.of(context).colorScheme.primary,
                ),
                AuthForm(
                  emailController: controller.emailController,
                  passwordController: controller.passwordController,
                  submitText: 'Registrar',
                  secondaryButtonText: 'Voltar para Login',
                  onSubmit: () => controller.onRegisterClick(context),
                  secondaryButtonAction: controller.goToLogin,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
