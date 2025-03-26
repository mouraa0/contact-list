import 'package:contact_list/core/error/failure.dart';
import 'package:contact_list/modules/auth/domain/entities/auth_entity.dart';
import 'package:contact_list/modules/contacts/domain/entities/contact_entity.dart';
import 'package:dartz/dartz.dart';

abstract class IContactRepository {
  Future<Either<Failure, List<ContactEntity>>> getContacts(AuthEntity user);
  Future<Either<Failure, void>> addContact(
    ContactEntity contact,
    AuthEntity user,
  );
  Future<Either<Failure, void>> deleteContact(
    ContactEntity contact,
    AuthEntity user,
  );
  Future<Either<Failure, void>> updateContact(
    ContactEntity contact,
    AuthEntity user,
  );
  Future<Either<Failure, void>> clearContacts(AuthEntity user);
  Future<Either<Failure, void>> editContact({
    required ContactEntity newContact,
    required ContactEntity oldContact,
    required AuthEntity user,
  });
}
