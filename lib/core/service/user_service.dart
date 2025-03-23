import 'package:contact_list/modules/auth/domain/entities/auth_entity.dart';

class UserService {
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
}
