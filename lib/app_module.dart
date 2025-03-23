import 'package:contact_list/modules/auth/auth_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  void routes(r) {
    r.module('/', module: AuthModule(), transition: TransitionType.fadeIn);
  }
}
