import 'package:contact_list/core/error/failure.dart';
import 'package:contact_list/modules/auth/domain/entities/auth_entity.dart';
import 'package:contact_list/modules/contacts/domain/entities/contact_entity.dart';
import 'package:contact_list/modules/contacts/domain/repositories/i_contact_repository.dart';
import 'package:dartz/dartz.dart';

abstract class IDoGetContactsUsecase {
  Future<Either<Failure, List<ContactEntity>>?> call(AuthEntity user);
}

class DoGetContactsUsecase implements IDoGetContactsUsecase {
  final IContactRepository repository;

  DoGetContactsUsecase(this.repository);

  @override
  Future<Either<Failure, List<ContactEntity>>?> call(AuthEntity user) =>
      repository.getContacts(user);
}
