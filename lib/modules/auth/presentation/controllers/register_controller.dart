import 'package:contact_list/core/error/failure.dart';
import 'package:contact_list/core/service/user_service.dart';
import 'package:contact_list/modules/auth/domain/entities/auth_entity.dart';
import 'package:contact_list/modules/auth/domain/entities/login_credentials_entity.dart';
import 'package:contact_list/modules/auth/domain/usecases/do_register_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/state_manager.dart';

class RegisterController extends GetXState {
  final IDoRegisterUsecase _doRegisterUsecase;

  RegisterController(this._doRegisterUsecase);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final isLoading = false.obs;

  void onRegisterClick(BuildContext context) async {
    isLoading.value = true;

    final credentials = AuthCredentialsEntity(
      email: emailController.text,
      password: passwordController.text,
    );

    final result = await _doRegisterUsecase.call(credentials);

    result.fold(_onRegisterError, _onRegisterSuccess);

    isLoading.value = false;
  }

  void _onRegisterError(error) {
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

  void _onRegisterSuccess(AuthEntity user) async {
    final userService = Modular.get<UserService>();

    userService.setUser(user);

    Modular.to.pushReplacementNamed('/contacts');
  }

  void goToLogin() {
    Modular.to.pushReplacementNamed('/');
  }
}
