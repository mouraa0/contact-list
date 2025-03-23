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

  void onRegisterClick() async {
    isLoading.value = true;

    final credentials = AuthCredentialsEntity(
      email: emailController.text,
      password: passwordController.text,
    );

    final result = await _doRegisterUsecase.call(credentials);

    result.fold(
      (error) => print('Error: $error'),
      (auth) => print('Auth: $auth'),
    );

    isLoading.value = false;
  }

  void goToLogin() {
    Modular.to.pushReplacementNamed('/');
  }
}
