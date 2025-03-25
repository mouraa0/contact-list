import 'package:contact_list/core/error/failure.dart';
import 'package:contact_list/modules/auth/domain/entities/auth_entity.dart';
import 'package:contact_list/modules/auth/domain/entities/login_credentials_entity.dart';
import 'package:dartz/dartz.dart';

abstract class IAuthRepository {
  Future<Either<Failure, void>> delete(AuthCredentialsEntity credentials);
  Future<Either<Failure, void>> logout();
  Future<Either<Failure, AuthEntity>> register(
    AuthCredentialsEntity credentials,
  );
  Future<Either<Failure, AuthEntity?>> getCurrentUser();
  Future<Either<Failure, AuthEntity>> login(AuthCredentialsEntity credentials);
}
