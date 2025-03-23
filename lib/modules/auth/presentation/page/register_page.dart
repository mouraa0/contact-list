import 'package:contact_list/core/constants/app_constants.dart';
import 'package:contact_list/core/validator/input_validator.dart';
import 'package:contact_list/core/widgets/buttons/submit_button.dart';
import 'package:contact_list/core/widgets/buttons/text_button.dart';
import 'package:contact_list/core/widgets/input/input_field.dart';
import 'package:contact_list/modules/auth/presentation/controllers/register_controller.dart';
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
                _Form(controller),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Form extends StatelessWidget {
  final RegisterController controller;

  const _Form(this.controller);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Column(
          spacing: AppConstants.formColumnSpacing,
          children: [
            InputField(
              headerText: 'E-mail',
              hintText: 'pessoa@gmail.com',
              controller: controller.emailController,
              validator: InputValidator.validateEmail,
            ),
            InputField(
              headerText: 'Senha',
              hintText: '******',
              controller: controller.passwordController,
              isPassword: true,
              validator: InputValidator.validatePassword,
            ),
            SizedBox(
              width: double.infinity,
              child: SubmitButton(
                formKey: formKey,
                text: 'Cadastrar',
                onSubmit: controller.onRegisterClick,
              ),
            ),
            AppTextButton(text: 'Login', onPressed: controller.goToLogin),
          ],
        ),
      ),
    );
  }
}
