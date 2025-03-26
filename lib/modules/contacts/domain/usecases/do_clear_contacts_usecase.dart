import 'package:contact_list/modules/auth/domain/entities/auth_entity.dart';
import 'package:contact_list/modules/contacts/domain/repositories/i_contact_repository.dart';

abstract class IDoClearContactsUsecase {
  Future<void> call(AuthEntity user);
}

class DoClearContactsUsecase implements IDoClearContactsUsecase {
  final IContactRepository _repository;

  DoClearContactsUsecase(this._repository);

  @override
  Future<void> call(AuthEntity user) => _repository.clearContacts(user);
}
