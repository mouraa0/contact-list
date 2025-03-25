import 'package:contact_list/core/error/failure.dart';
import 'package:contact_list/modules/auth/domain/entities/auth_entity.dart';
import 'package:contact_list/modules/contacts/domain/entities/contact_entity.dart';
import 'package:contact_list/modules/contacts/domain/repositories/i_contact_repository.dart';
import 'package:dartz/dartz.dart';

abstract class IDoAddContactUsecase {
  Future<Either<Failure, void>> call(ContactEntity contact, AuthEntity user);
}

class DoAddContactUsecase implements IDoAddContactUsecase {
  final IContactRepository repository;

  DoAddContactUsecase(this.repository);

  @override
  Future<Either<Failure, void>> call(ContactEntity contact, AuthEntity user) =>
      repository.addContact(contact, user);
}
