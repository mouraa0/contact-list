import 'package:contact_list/core/error/failure.dart';
import 'package:contact_list/modules/contacts/domain/entities/address_entity.dart';
import 'package:contact_list/modules/contacts/domain/entities/autocomplete_address_entity.dart';
import 'package:dartz/dartz.dart';

abstract class IAddressRepository {
  Future<Either<Failure, List<AutocompleteAddressEntity>>> getAddressByInput(
    String input,
  );
  Future<Either<Failure, AddressEntity>> getAddressDetails(
    AutocompleteAddressEntity address,
  );
  Future<Either<Failure, List<double>>> getLatLng(AddressEntity address);
}
