import 'package:equatable/equatable.dart';

class AutocompleteAddressEntity extends Equatable {
  final String description;
  final String placeId;

  const AutocompleteAddressEntity({
    required this.description,
    required this.placeId,
  });

  @override
  List<Object?> get props => [description, placeId];
}
