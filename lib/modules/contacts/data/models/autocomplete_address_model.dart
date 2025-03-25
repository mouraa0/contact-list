import 'package:contact_list/modules/contacts/domain/entities/autocomplete_address_entity.dart';

class AutocompleteAddressModel extends AutocompleteAddressEntity {
  const AutocompleteAddressModel({
    required super.description,
    required super.placeId,
  });

  factory AutocompleteAddressModel.fromMap(Map<String, dynamic> map) {
    return AutocompleteAddressModel(
      description: map['description'],
      placeId: map['place_id'],
    );
  }

  Map<String, dynamic> toMap() {
    return {'description': description, 'place_id': placeId};
  }
}
