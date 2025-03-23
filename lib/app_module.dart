import 'package:contact_list/core/service/user_service.dart';
import 'package:contact_list/modules/auth/auth_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  List<Module> get imports => [AuthModule()];

  void _services(Injector i) {
    i.addInstance(() => UserService());
  }

  @override
  void binds(Injector i) {
    _services(i);
  }

  @override
  void routes(r) {
    r.module('/', module: AuthModule(), transition: TransitionType.fadeIn);
  }
}
