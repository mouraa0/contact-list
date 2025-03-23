import 'package:contact_list/modules/auth/domain/entities/login_credentials_entity.dart';
import 'package:contact_list/modules/auth/domain/usecases/do_login_usecase.dart';
import 'package:flutter/widgets.dart';
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

  String? validateEmail(value) {
    if (value == null || value.isEmpty) {
      return 'Este campo é obrigatório';
    }

    if (value.length < 3) {
      return 'Deve ter pelo menos 3 caracteres';
    }

    if (value.length > 20) {
      return 'Deve ter menos de 20 caracteres';
    }

    if (value.contains('@') == false) {
      return 'Deve ser um email válido';
    }

    return null;
  }

  String? validatePassword(value) {
    if (value == null || value.isEmpty) {
      return 'Este campo é obrigatório';
    }

    if (value.length < 5) {
      return 'Deve ter pelo menos 5 caracteres';
    }

    if (value.length > 20) {
      return 'Deve ter menos de 20 caracteres';
    }

    return null;
  }
}
