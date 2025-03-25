import 'package:contact_list/modules/contacts/domain/entities/address_entity.dart';
import 'package:equatable/equatable.dart';

class ContactEntity extends Equatable {
  final String name;
  final String cpf;
  final String phone;
  final AddressEntity address;

  const ContactEntity({
    required this.name,
    required this.cpf,
    required this.phone,
    required this.address,
  });

  @override
  List<Object?> get props => [name, cpf, phone, address];
}
