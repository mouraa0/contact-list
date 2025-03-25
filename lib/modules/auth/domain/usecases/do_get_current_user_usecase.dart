import 'package:contact_list/core/error/failure.dart';
import 'package:contact_list/modules/auth/domain/entities/auth_entity.dart';
import 'package:contact_list/modules/auth/domain/repository/i_auth_repository.dart';
import 'package:dartz/dartz.dart';

abstract class IDoGetCurrentUserUsecase {
  Future<Either<Failure, AuthEntity?>> call();
}

class DoGetCurrentUserUsecase implements IDoGetCurrentUserUsecase {
  final IAuthRepository repository;

  DoGetCurrentUserUsecase(this.repository);

  @override
  Future<Either<Failure, AuthEntity?>> call() => repository.getCurrentUser();
}
