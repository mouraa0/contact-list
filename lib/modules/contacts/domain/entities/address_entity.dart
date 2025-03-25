import 'package:equatable/equatable.dart';

class AddressEntity extends Equatable {
  final String street;
  final String number;
  final String city;
  final String state;
  final String cep;
  final double lat;
  final double lng;
  final String? complement;

  const AddressEntity({
    required this.street,
    required this.number,
    required this.city,
    required this.state,
    required this.cep,
    required this.lat,
    required this.lng,
    this.complement,
  });

  @override
  List<Object?> get props => [street, number, city, state, cep];
}
