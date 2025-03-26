import 'dart:convert';
import 'package:contact_list/core/error/failure.dart';
import 'package:contact_list/modules/auth/data/model/auth_model.dart';
import 'package:contact_list/modules/auth/domain/entities/login_credentials_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthDatasource {
  Future<AuthModel> login(AuthCredentialsEntity credentials);
  Future<AuthModel> register(AuthCredentialsEntity credentials);
  Future<AuthModel?> getCurrentUser();
  Future<void> delete(AuthCredentialsEntity credentials);
  Future<void> logout();
}

class AuthDatasourceImpl implements AuthDatasource {
  @override
  Future<AuthModel> login(AuthCredentialsEntity credentials) async {
    final preferences = await SharedPreferences.getInstance();
    final data = preferences.getString(credentials.email);

    if (data == null) {
      throw AuthFailure(message: 'Conta não foi encontrada!');
    }

    final account = json.decode(data);

    if (account['password'] == credentials.password) {
      await preferences.setString('currentUser', credentials.email);

      return AuthModel(email: credentials.email);
    }

    throw AuthFailure(message: 'Credenciais inválidas!');
  }

  @override
  Future<AuthModel> register(AuthCredentialsEntity credentials) async {
    final preferences = await SharedPreferences.getInstance();
    final data = preferences.getString(credentials.email);

    if (data != null) {
      throw AuthFailure(message: 'Conta já existe');
    }

    final account = json.encode(credentials.toMap());
    await preferences.setString(credentials.email, account);

    return AuthModel(email: credentials.email);
  }

  @override
  Future<AuthModel?> getCurrentUser() async {
    final preferences = await SharedPreferences.getInstance();
    final email = preferences.getString('currentUser');

    if (email == null) {
      return null;
    }

    return AuthModel(email: email);
  }

  @override
  Future<void> delete(AuthCredentialsEntity credentials) async {
    final preferences = await SharedPreferences.getInstance();
    final data = preferences.getString(credentials.email);

    if (data == null) {
      throw AuthFailure(message: 'Conta não foi encontrada!');
    }

    await preferences.remove(credentials.email);
  }

  @override
  Future<void> logout() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.remove('currentUser');
  }
}
