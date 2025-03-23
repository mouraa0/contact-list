import 'package:contact_list/modules/auth/data/datasource/auth_datasource.dart';
import 'package:contact_list/modules/auth/data/repository/auth_repository.dart';
import 'package:contact_list/modules/auth/domain/repository/i_auth_repository.dart';
import 'package:contact_list/modules/auth/domain/usecases/do_delete_usecase.dart';
import 'package:contact_list/modules/auth/domain/usecases/do_login_usecase.dart';
import 'package:contact_list/modules/auth/domain/usecases/do_logout_usecase.dart';
import 'package:contact_list/modules/auth/domain/usecases/do_register_usecase.dart';
import 'package:contact_list/modules/auth/presentation/controllers/login_controller.dart';
import 'package:contact_list/modules/auth/presentation/page/login_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AuthModule extends Module {
  void _datasources(Injector i) {
    i.addSingleton<AuthDatasource>(() => AuthDatasourceImpl());
  }

  void _controllers(Injector i) {
    i.addSingleton<LoginController>(() => LoginController(i.get()));
  }

  void _usecases(Injector i) {
    i.addSingleton<IDoLoginUsecase>(() => DoLoginUsecase(i.get()));
    i.addSingleton<IDoDeleteUsecase>(() => DoDeleteUsecase(i.get()));
    i.addSingleton<IDoLogoutUsecase>(() => DoLogoutUsecase(i.get()));
    i.addSingleton<IDoRegisterUsecase>(() => DoRegisterUsecase(i.get()));
  }

  void _repositories(Injector i) {
    i.addSingleton<IAuthRepository>(() => AuthRepository(i.get()));
  }

  @override
  void binds(Injector i) {
    _datasources(i);
    _repositories(i);
    _usecases(i);
    _controllers(i);
  }

  @override
  void routes(r) {
    r.child(
      '/',
      child: (context) => LoginPage(controller: Modular.get<LoginController>()),
    );
  }
}
