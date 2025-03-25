import 'package:contact_list/modules/contacts/domain/entities/address_entity.dart';
import 'package:get/get.dart';

class AddressModel extends AddressEntity {
  const AddressModel({
    required super.cep,
    required super.city,
    required super.lat,
    required super.lng,
    required super.number,
    required super.state,
    required super.street,
    super.complement,
  });

  factory AddressModel.fromMap(Map<String, dynamic> map) {
    final cep = (map['address_components'] as List).firstWhereOrNull(
      (element) => element['types'].contains('postal_code'),
    );

    final number = (map['address_components'] as List).firstWhereOrNull(
      (element) => element['types'].contains('street_number'),
    );

    return AddressModel(
      cep: cep?['long_name'] ?? '',
      city:
          (map['address_components'] as List).firstWhere(
            (element) =>
                element['types'].contains('administrative_area_level_2'),
          )['long_name'],
      lat: map['geometry']['location']['lat'],
      lng: map['geometry']['location']['lng'],
      number: number?['long_name'] ?? '',
      state:
          (map['address_components'] as List).firstWhere(
            (element) =>
                element['types'].contains('administrative_area_level_1'),
          )['short_name'],
      complement: map['complement'] ?? '',
      street:
          (map['address_components'] as List).firstWhere(
            (element) => element['types'].contains('route'),
          )['long_name'],
    );
  }

  factory AddressModel.fromLocalStorage(Map<String, dynamic> map) {
    return AddressModel(
      cep: map['cep'],
      city: map['city'],
      lat: map['lat'],
      lng: map['lng'],
      number: map['number'],
      state: map['state'],
      street: map['street'],
      complement: map['complement'],
    );
  }

  factory AddressModel.fromEntity(AddressEntity entity) {
    return AddressModel(
      cep: entity.cep,
      city: entity.city,
      lat: entity.lat,
      lng: entity.lng,
      number: entity.number,
      state: entity.state,
      complement: entity.complement,
      street: entity.street,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'cep': cep,
      'city': city,
      'lat': lat,
      'lng': lng,
      'number': number,
      'state': state,
      'street': street,
      'complement': complement,
    };
  }
}
