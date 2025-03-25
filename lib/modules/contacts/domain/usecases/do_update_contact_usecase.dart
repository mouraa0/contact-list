import 'package:contact_list/core/error/failure.dart';
import 'package:contact_list/modules/auth/domain/entities/auth_entity.dart';
import 'package:contact_list/modules/contacts/domain/entities/contact_entity.dart';
import 'package:contact_list/modules/contacts/domain/repositories/i_contact_repository.dart';
import 'package:dartz/dartz.dart';

abstract class IDoUpdateContactUsecase {
  Future<Either<Failure, void>> call(ContactEntity contact, AuthEntity user);
}

class DoUpdateContactUsecase implements IDoUpdateContactUsecase {
  final IContactRepository repository;

  DoUpdateContactUsecase(this.repository);

  @override
  Future<Either<Failure, void>> call(ContactEntity contact, AuthEntity user) =>
      repository.updateContact(contact, user);
}
