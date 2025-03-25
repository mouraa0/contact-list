import 'package:contact_list/core/error/failure.dart';
import 'package:contact_list/modules/contacts/domain/entities/autocomplete_address_entity.dart';
import 'package:contact_list/modules/contacts/domain/repositories/i_address_repository.dart';
import 'package:dartz/dartz.dart';

abstract class IDoGetAutocompleteAddressUsecase {
  Future<Either<Failure, List<AutocompleteAddressEntity>>> call(String input);
}

class DoGetAutocompleteAddressUsecase
    implements IDoGetAutocompleteAddressUsecase {
  final IAddressRepository repository;

  DoGetAutocompleteAddressUsecase(this.repository);

  @override
  Future<Either<Failure, List<AutocompleteAddressEntity>>> call(String input) =>
      repository.getAddressByInput(input);
}
