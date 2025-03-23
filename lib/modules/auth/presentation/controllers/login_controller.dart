import 'package:contact_list/modules/auth/domain/entities/login_credentials_entity.dart';
import 'package:contact_list/modules/auth/domain/usecases/do_login_usecase.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/state_manager.dart';

class LoginController extends GetXState {
  final IDoLoginUsecase _doLoginUsecase;

  LoginController(this._doLoginUsecase);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final isLoading = false.obs;

  void onLoginClick() async {
    isLoading.value = true;

    final credentials = AuthCredentialsEntity(
      email: emailController.text,
      password: passwordController.text,
    );

    final result = await _doLoginUsecase.call(credentials);

    result.fold(
      (error) => print('Error: $error'),
      (auth) => print('Auth: $auth'),
    );

    isLoading.value = false;
  }

  void goToRegister() {
    Modular.to.pushReplacementNamed('/register');
  }
}
