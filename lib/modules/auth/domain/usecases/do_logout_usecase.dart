import 'package:contact_list/core/error/failure.dart';
import 'package:contact_list/modules/auth/domain/repository/i_auth_repository.dart';
import 'package:dartz/dartz.dart';

abstract class IDoLogoutUsecase {
  Future<Either<Failure, void>> call();
}

class DoLogoutUsecase implements IDoLogoutUsecase {
  final IAuthRepository _repository;

  DoLogoutUsecase(this._repository);

  @override
  Future<Either<Failure, void>> call() => _repository.logout();
}
