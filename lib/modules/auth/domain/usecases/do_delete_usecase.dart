import 'package:contact_list/core/error/failure.dart';
import 'package:contact_list/modules/auth/domain/entities/login_credentials_entity.dart';
import 'package:contact_list/modules/auth/domain/repository/i_auth_repository.dart';
import 'package:dartz/dartz.dart';

abstract class IDoDeleteUsecase {
  Future<Either<Failure, void>> call(AuthCredentialsEntity credentials);
}

class DoDeleteUsecase implements IDoDeleteUsecase {
  final IAuthRepository _repository;

  DoDeleteUsecase(this._repository);

  @override
  Future<Either<Failure, void>> call(AuthCredentialsEntity credentials) =>
      _repository.delete(credentials);
}
