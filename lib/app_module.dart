import 'package:contact_list/modules/auth/auth_module.dart';
import 'package:contact_list/modules/contacts/contacts_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  List<Module> get imports => [AuthModule()];

  @override
  void routes(r) {
    r.module('/', module: AuthModule(), transition: TransitionType.fadeIn);
    r.module(
      '/contacts',
      module: ContactsModule(),
      transition: TransitionType.fadeIn,
    );
  }
}
