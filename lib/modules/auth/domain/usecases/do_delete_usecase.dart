import 'package:contact_list/core/error/failure.dart';
import 'package:contact_list/modules/auth/domain/entities/auth_entity.dart';
import 'package:contact_list/modules/auth/domain/repository/i_auth_repository.dart';
import 'package:dartz/dartz.dart';

abstract class IDoDeleteAccountUsecase {
  Future<Either<Failure, void>> call(AuthEntity credentials);
}

class DoDeleteAccountUsecase implements IDoDeleteAccountUsecase {
  final IAuthRepository _repository;

  DoDeleteAccountUsecase(this._repository);

  @override
  Future<Either<Failure, void>> call(AuthEntity credentials) =>
      _repository.delete(credentials);
}
