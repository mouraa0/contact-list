import 'package:contact_list/core/constants/app_constants.dart';
import 'package:contact_list/core/widgets/buttons/button.dart';
import 'package:contact_list/core/widgets/buttons/submit_button.dart';
import 'package:contact_list/core/widgets/input/input_field.dart';
import 'package:contact_list/modules/auth/presentation/controllers/login_controller.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  final LoginController controller;

  const LoginPage({super.key, required this.controller});

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
  final LoginController controller;

  const _Form(this.controller);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Column(
          spacing: 20,
          children: [
            _InputHeader('E-mail'),
            InputField(
              hintText: 'pessoa@gmail.com',
              controller: controller.emailController,
              validator: controller.validateEmail,
            ),
            _InputHeader('Senha'),
            InputField(
              hintText: '******',
              controller: controller.passwordController,
              isPassword: true,
              validator: controller.validatePassword,
            ),
            SizedBox(
              width: double.infinity,
              child: SubmitButton(
                formKey: formKey,
                text: 'Login',
                disabled:
                    formKey.currentState == null ||
                    formKey.currentState!.validate() == false,
                onSubmit: controller.onLoginClick,
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Button(
                text: 'Cadastrar',
                type: ButtonType.secondary,
                onPressed: () => {print('Test')},
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InputHeader extends StatelessWidget {
  final String text;

  const _InputHeader(this.text);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: TextStyle(
          fontSize: AppConstants.headingSmallerFontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
