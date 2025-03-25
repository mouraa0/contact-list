import 'package:contact_list/core/error/failure.dart';
import 'package:contact_list/modules/contacts/domain/entities/address_entity.dart';
import 'package:contact_list/modules/contacts/domain/entities/autocomplete_address_entity.dart';
import 'package:contact_list/modules/contacts/domain/repositories/i_address_repository.dart';
import 'package:dartz/dartz.dart';

abstract class IDoGetAddressDetailsUsecase {
  Future<Either<Failure, AddressEntity>> call(
    AutocompleteAddressEntity address,
  );
}

class DoGetAddressDetailsUsecase implements IDoGetAddressDetailsUsecase {
  final IAddressRepository repository;

  DoGetAddressDetailsUsecase(this.repository);

  @override
  Future<Either<Failure, AddressEntity>> call(
    AutocompleteAddressEntity address,
  ) => repository.getAddressDetails(address);
}
