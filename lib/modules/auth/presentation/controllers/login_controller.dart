import 'package:contact_list/core/error/failure.dart';
import 'package:contact_list/core/service/user_service.dart';
import 'package:contact_list/modules/auth/domain/entities/auth_entity.dart';
import 'package:contact_list/modules/auth/domain/entities/login_credentials_entity.dart';
import 'package:contact_list/modules/auth/domain/usecases/do_login_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

class LoginController extends GetXState {
  final IDoLoginUsecase _doLoginUsecase;

  LoginController(this._doLoginUsecase);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final isLoading = false.obs;

  void onLoginClick(BuildContext context) async {
    isLoading.value = true;

    final credentials = AuthCredentialsEntity(
      email: emailController.text,
      password: passwordController.text,
    );

    final result = await _doLoginUsecase.call(credentials);

    result.fold((error) => _onLoginError(context, error), _onLoginSuccess);

    isLoading.value = false;
  }

  void _onLoginError(BuildContext context, error) {
    final scaffold = ScaffoldMessenger.of(context);

    scaffold.showSnackBar(
      SnackBar(
        content: Text((error as AuthFailure).message),
        action: SnackBarAction(
          label: 'Fechar',
          onPressed: scaffold.hideCurrentSnackBar,
        ),
      ),
    );
  }

  void _onLoginSuccess(AuthEntity user) async {
    final userService = Modular.get<UserService>();

    userService.setUser(user);

    clearFields();
    Modular.to.pushReplacementNamed('/contacts');
  }

  void goToRegister() {
    clearFields();
    Modular.to.pushReplacementNamed('/register');
  }

  void clearFields() {
    emailController.clear();
    passwordController.clear();
  }
}
