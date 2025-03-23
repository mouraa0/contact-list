import 'package:contact_list/core/error/failure.dart';
import 'package:contact_list/modules/auth/domain/entities/auth_entity.dart';
import 'package:contact_list/modules/auth/domain/entities/login_credentials_entity.dart';
import 'package:contact_list/modules/auth/domain/repository/i_auth_repository.dart';
import 'package:dartz/dartz.dart';

abstract class IDoLoginUsecase {
  Future<Either<Failure, AuthEntity>> call(AuthCredentialsEntity credentials);
}

class DoLoginUsecase implements IDoLoginUsecase {
  final IAuthRepository _repository;

  DoLoginUsecase(this._repository);

  @override
  Future<Either<Failure, AuthEntity>> call(AuthCredentialsEntity credentials) =>
      _repository.login(credentials);
}
