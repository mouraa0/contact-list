import 'package:contact_list/core/error/failure.dart';
import 'package:contact_list/modules/contacts/data/datasource/address_datasource.dart';
import 'package:contact_list/modules/contacts/domain/entities/address_entity.dart';
import 'package:contact_list/modules/contacts/domain/entities/autocomplete_address_entity.dart';
import 'package:contact_list/modules/contacts/domain/repositories/i_address_repository.dart';
import 'package:dartz/dartz.dart';

class AddressRepository implements IAddressRepository {
  final AddressDatasource _datasource;

  AddressRepository(this._datasource);

  @override
  Future<Either<Failure, List<AutocompleteAddressEntity>>> getAddressByInput(
    String input,
  ) async {
    try {
      final response = await _datasource.getAddressByInput(input);

      return Right(response as List<AutocompleteAddressEntity>);
    } catch (e) {
      return Left(e is Failure ? e : AddressFailure(message: 'Error'));
    }
  }

  @override
  Future<Either<Failure, AddressEntity>> getAddressDetails(
    AutocompleteAddressEntity address,
  ) async {
    try {
      final response = await _datasource.getAddressDetails(address.placeId);

      return Right(response as AddressEntity);
    } catch (e) {
      return Left(e is Failure ? e : AddressFailure(message: 'Error'));
    }
  }

  @override
  Future<Either<Failure, List<double>>> getLatLng(AddressEntity address) async {
    try {
      final response = await _datasource.getLatLng(address);

      return Right(response);
    } catch (e) {
      return Left(e is Failure ? e : AddressFailure(message: 'Error'));
    }
  }
}
