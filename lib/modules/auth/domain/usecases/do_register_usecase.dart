import 'package:contact_list/core/error/failure.dart';
import 'package:contact_list/modules/auth/domain/entities/auth_entity.dart';
import 'package:contact_list/modules/auth/domain/entities/login_credentials_entity.dart';
import 'package:contact_list/modules/auth/domain/repository/i_auth_repository.dart';
import 'package:dartz/dartz.dart';

abstract class IDoRegisterUsecase {
  Future<Either<Failure, AuthEntity>> call(AuthCredentialsEntity credentials);
}

class DoRegisterUsecase implements IDoRegisterUsecase {
  final IAuthRepository _repository;

  DoRegisterUsecase(this._repository);

  @override
  Future<Either<Failure, AuthEntity>> call(AuthCredentialsEntity credentials) =>
      _repository.register(credentials);
}
