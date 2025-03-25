import 'dart:convert';

import 'package:contact_list/modules/contacts/data/models/address_model.dart';
import 'package:contact_list/modules/contacts/data/models/autocomplete_address_model.dart';
import 'package:contact_list/modules/contacts/domain/entities/address_entity.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

abstract class AddressDatasource {
  Future<List<AutocompleteAddressModel>> getAddressByInput(String input);
  Future<AddressModel> getAddressDetails(String placeId);
  Future<List<double>> getLatLng(AddressEntity address);
}

class AddressDatasourceImpl implements AddressDatasource {
  static final _apiKey = dotenv.env['GOOGLE_API_KEY'];

  final String _autocompleteUrl =
      'https://maps.googleapis.com/maps/api/place/autocomplete/json?&ypes=address&key=$_apiKey&language=pt_BR';

  final String _detailsUrl =
      'https://maps.googleapis.com/maps/api/place/details/json?&key=$_apiKey&language=pt_BR';

  @override
  Future<List<AutocompleteAddressModel>> getAddressByInput(String input) async {
    final url = Uri.parse('$_autocompleteUrl&input=$input');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final predictions = data['predictions'] as List;

      return predictions
          .map((e) => AutocompleteAddressModel.fromMap(e))
          .toList();
    }

    throw Exception('Erro ao buscar endereços');
  }

  @override
  Future<AddressModel> getAddressDetails(String placeId) async {
    final url = Uri.parse('$_detailsUrl&place_id=$placeId');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final result = data['result'];

      return AddressModel.fromMap(result);
    }

    throw Exception('Erro ao buscar detalhes do endereço');
  }

  @override
  Future<List<double>> getLatLng(AddressEntity address) async {
    final url = Uri.parse(
      'https://maps.googleapis.com/maps/api/geocode/json?address=${address.street},+${address.number},+${address.city},+${address.state},+BR&key=$_apiKey',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final results = data['results'] as List;

      if (results.isNotEmpty) {
        final location = results.first['geometry']['location'];

        return [location['lat'], location['lng']];
      }
    }

    throw Exception('Erro ao buscar coordenadas');
  }
}
