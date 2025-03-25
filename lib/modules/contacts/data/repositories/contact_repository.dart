import 'package:contact_list/core/error/failure.dart';
import 'package:contact_list/modules/auth/domain/entities/auth_entity.dart';
import 'package:contact_list/modules/contacts/data/datasource/contact_datasource.dart';
import 'package:contact_list/modules/contacts/data/models/contact_model.dart';
import 'package:contact_list/modules/contacts/domain/entities/contact_entity.dart';
import 'package:contact_list/modules/contacts/domain/repositories/i_contact_repository.dart';
import 'package:dartz/dartz.dart';

class ContactRepository implements IContactRepository {
  final ContactDatasource _datasource;

  ContactRepository(this._datasource);

  @override
  Future<Either<Failure, void>> addContact(
    ContactEntity contact,
    AuthEntity user,
  ) async {
    try {
      await _datasource.addContact(ContactModel.fromEntity(contact), user);

      return Right(null);
    } catch (e) {
      return Left(e is Failure ? e : ContactFailure(message: 'Error'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteContact(
    ContactEntity contact,
    AuthEntity user,
  ) async {
    try {
      await _datasource.deleteContact(ContactModel.fromEntity(contact), user);

      return Right(null);
    } catch (e) {
      return Left(e is Failure ? e : ContactFailure(message: 'Error'));
    }
  }

  @override
  Future<Either<Failure, List<ContactEntity>>> getContacts(
    AuthEntity user,
  ) async {
    try {
      final contacts = await _datasource.getContacts(user);

      return Right(contacts as List<ContactEntity>);
    } catch (e) {
      return Left(e is Failure ? e : ContactFailure(message: 'Error'));
    }
  }

  @override
  Future<Either<Failure, void>> updateContact(
    ContactEntity contact,
    AuthEntity user,
  ) async {
    try {
      await _datasource.updateContact(ContactModel.fromEntity(contact), user);

      return Right(null);
    } catch (e) {
      return Left(e is Failure ? e : ContactFailure(message: 'Error'));
    }
  }
}
