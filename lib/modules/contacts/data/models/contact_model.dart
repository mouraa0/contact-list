import 'package:contact_list/modules/contacts/data/models/address_model.dart';
import 'package:contact_list/modules/contacts/domain/entities/contact_entity.dart';

class ContactModel extends ContactEntity {
  const ContactModel({
    required super.address,
    required super.cpf,
    required super.name,
    required super.phone,
  });

  factory ContactModel.fromEntity(ContactEntity entity) {
    return ContactModel(
      address: AddressModel.fromEntity(entity.address),
      cpf: entity.cpf,
      name: entity.name,
      phone: entity.phone,
    );
  }

  factory ContactModel.fromMap(Map<String, dynamic> map) {
    return ContactModel(
      address: AddressModel.fromLocalStorage(map['address']),
      cpf: map['cpf'],
      name: map['name'],
      phone: map['phone'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'address': (address as AddressModel).toMap(),
      'cpf': cpf,
      'name': name,
      'phone': phone,
    };
  }
}
