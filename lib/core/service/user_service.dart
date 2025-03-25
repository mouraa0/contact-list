import 'package:contact_list/core/error/failure.dart';
import 'package:contact_list/modules/auth/domain/entities/auth_entity.dart';
import 'package:contact_list/modules/auth/domain/usecases/do_get_current_user_usecase.dart';

class UserService {
  final IDoGetCurrentUserUsecase _doGetCurrentUserUsecase;

  UserService(this._doGetCurrentUserUsecase) {
    _loadUser();
  }

  AuthEntity? _user;

  AuthEntity? get user => _user;

  void setUser(AuthEntity user) {
    _user = user;
  }

  void logout() {
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
