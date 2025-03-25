import 'package:contact_list/core/error/failure.dart';
import 'package:contact_list/modules/contacts/domain/entities/address_entity.dart';
import 'package:contact_list/modules/contacts/domain/repositories/i_address_repository.dart';
import 'package:dartz/dartz.dart';

abstract class IDoGetLatLngUsecase {
  Future<Either<Failure, List<double>>> call(AddressEntity address);
}

class DoGetLatLngUsecase implements IDoGetLatLngUsecase {
  final IAddressRepository repository;

  DoGetLatLngUsecase(this.repository);

  @override
  Future<Either<Failure, List<double>>> call(AddressEntity address) =>
      repository.getLatLng(address);
}
