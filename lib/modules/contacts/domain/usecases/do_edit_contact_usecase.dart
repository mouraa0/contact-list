import 'package:contact_list/modules/auth/domain/entities/auth_entity.dart';
import 'package:contact_list/modules/contacts/domain/entities/contact_entity.dart';
import 'package:contact_list/modules/contacts/domain/repositories/i_contact_repository.dart';

abstract class IDoEditContactUsecase {
  Future<void> call({
    required ContactEntity newContact,
    required ContactEntity oldContact,
    required AuthEntity user,
  });
}

class DoEditContactUsecase implements IDoEditContactUsecase {
  final IContactRepository _repository;

  DoEditContactUsecase(this._repository);

  @override
  Future<void> call({
    required ContactEntity newContact,
    required ContactEntity oldContact,
    required AuthEntity user,
  }) => _repository.editContact(
    newContact: newContact,
    oldContact: oldContact,
    user: user,
  );
}
