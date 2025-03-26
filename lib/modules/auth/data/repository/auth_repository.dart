import 'package:contact_list/core/error/failure.dart';
import 'package:contact_list/modules/auth/data/datasource/auth_datasource.dart';
import 'package:contact_list/modules/auth/domain/entities/auth_entity.dart';
import 'package:contact_list/modules/auth/domain/entities/login_credentials_entity.dart';
import 'package:contact_list/modules/auth/domain/repository/i_auth_repository.dart';
import 'package:dartz/dartz.dart';

class AuthRepository implements IAuthRepository {
  final AuthDatasource _datasource;

  AuthRepository(this._datasource);

  @override
  Future<Either<Failure, void>> delete(AuthEntity credentials) async {
    try {
      await _datasource.delete(credentials);

      return Right(null);
    } catch (e) {
      return Left(e is Failure ? e : AuthFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await _datasource.logout();

      return Right(null);
    } catch (e) {
      return Left(e is Failure ? e : AuthFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthEntity?>> getCurrentUser() async {
    try {
      final result = await _datasource.getCurrentUser();

      return Right(result);
    } catch (e) {
      return Left(e is Failure ? e : AuthFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthEntity>> register(
    AuthCredentialsEntity credentials,
  ) async {
    try {
      final result = await _datasource.register(credentials);

      return Right(result as AuthEntity);
    } catch (e) {
      return Left(e is Failure ? e : AuthFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthEntity>> login(
    AuthCredentialsEntity credentials,
  ) async {
    try {
      final result = await _datasource.login(credentials);

      return Right(result as AuthEntity);
    } catch (e) {
      return Left(e is Failure ? e : AuthFailure(message: e.toString()));
    }
  }
}
