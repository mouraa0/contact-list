import 'package:contact_list/core/constants/app_constants.dart';
import 'package:contact_list/core/validator/input_validator.dart';
import 'package:contact_list/core/widgets/buttons/submit_button.dart';
import 'package:contact_list/core/widgets/buttons/text_button.dart';
import 'package:contact_list/core/widgets/input/input_field.dart';
import 'package:flutter/widgets.dart';

class AuthForm extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final String submitText;
  final String secondaryButtonText;
  final VoidCallback onSubmit;
  final VoidCallback secondaryButtonAction;

  const AuthForm({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.submitText,
    required this.secondaryButtonText,
    required this.onSubmit,
    required this.secondaryButtonAction,
  });

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
              controller: emailController,
              validator: InputValidator.validateEmail,
            ),
            InputField(
              headerText: 'Senha',
              hintText: '******',
              controller: passwordController,
              isPassword: true,
              validator: InputValidator.validatePassword,
            ),
            SizedBox(
              width: double.infinity,
              child: SubmitButton(
                formKey: formKey,
                text: submitText,
                onSubmit: onSubmit,
              ),
            ),
            AppTextButton(
              text: secondaryButtonText,
              onPressed: secondaryButtonAction,
            ),
          ],
        ),
      ),
    );
  }
}
