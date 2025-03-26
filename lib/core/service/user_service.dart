import 'package:contact_list/core/error/failure.dart';
import 'package:contact_list/modules/auth/domain/entities/auth_entity.dart';
import 'package:contact_list/modules/auth/domain/usecases/do_delete_usecase.dart';
import 'package:contact_list/modules/auth/domain/usecases/do_get_current_user_usecase.dart';
import 'package:contact_list/modules/auth/domain/usecases/do_logout_usecase.dart';
import 'package:flutter_modular/flutter_modular.dart';

class UserService {
  final IDoGetCurrentUserUsecase _doGetCurrentUserUsecase;
  final IDoLogoutUsecase _doLogoutUsecase;
  final IDoDeleteAccountUsecase _doDeleteUsecase;

  UserService(
    this._doGetCurrentUserUsecase,
    this._doLogoutUsecase,
    this._doDeleteUsecase,
  ) {
    _loadUser();
  }

  AuthEntity? _user;

  AuthEntity? get user => _user;

  void setUser(AuthEntity user) {
    _user = user;
  }

  void logout() async {
    _user = null;
    await _doLogoutUsecase();

    Modular.to.popAndPushNamed('/');
  }

  Future<void> deleteAccount() async {
    await _doDeleteUsecase(_user!);
    _user = null;
  }

  bool isLogged() {
    return _user != null;
  }

  void _loadUser() async {
    try {
      final result = await _doGetCurrentUserUsecase();

      result.fold(
        (failure) {
          print((failure as AuthFailure).message);
        },
        (user) {
          _user = user;
        },
      );
    } catch (e) {
      print(e);
    }
  }
}
