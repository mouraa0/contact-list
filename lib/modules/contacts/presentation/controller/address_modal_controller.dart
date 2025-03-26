import 'dart:async';

import 'package:contact_list/core/error/failure.dart';
import 'package:contact_list/modules/contacts/domain/entities/address_entity.dart';
import 'package:contact_list/modules/contacts/domain/entities/autocomplete_address_entity.dart';
import 'package:contact_list/modules/contacts/domain/entities/contact_entity.dart';
import 'package:contact_list/modules/contacts/domain/usecases/do_get_address_details_usecase.dart';
import 'package:contact_list/modules/contacts/domain/usecases/do_get_autocomplete_address_usecase.dart';
import 'package:contact_list/modules/contacts/domain/usecases/do_get_lat_lng_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/state_manager.dart';

class AddressModalController extends GetxController {
  final IDoGetAutocompleteAddressUsecase _doGetAutocompleteAddressUsecase;
  final IDoGetAddressDetailsUsecase _doGetAddressDetailsUsecase;
  final IDoGetLatLngUsecase _doGetLatLngUsecase;

  AddressModalController(
    this._doGetAutocompleteAddressUsecase,
    this._doGetAddressDetailsUsecase,
    this._doGetLatLngUsecase,
  );

  final TextEditingController searchController = TextEditingController();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController cpfController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  final TextEditingController streetController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController postalCodeController = TextEditingController();

  RxList<AutocompleteAddressEntity> autocompleteItems =
      <AutocompleteAddressEntity>[].obs;

  RxBool isLoading = false.obs;

  AutocompleteAddressEntity? selectedAddress;

  void initDialog(ContactEntity? contact) async {
    if (contact == null) {
      return;
    }

    nameController.text = contact.name;
    cpfController.text = contact.cpf;
    phoneController.text = contact.phone;
    streetController.text = contact.address.street;
    numberController.text = contact.address.number;
    cityController.text = contact.address.city;
    stateController.text = contact.address.state;
    postalCodeController.text = contact.address.cep;
  }

  Future<List<AutocompleteAddressEntity>> onSearchChanged(String? value) async {
    if (value == null || value.isEmpty) {
      return [];
    }

    final result = await _doGetAutocompleteAddressUsecase(value);

    List<AutocompleteAddressEntity> list = [];

    result.fold(
      (failure) {
        print((failure as AddressFailure).message);
      },
      (addresses) {
        list = addresses;
      },
    );

    return list;
  }

  void onAutocompleteSelected(AutocompleteAddressEntity address) async {
    selectedAddress = address;

    final result = await _doGetAddressDetailsUsecase(address);

    result.fold(
      (failure) {
        print((failure as AddressFailure).message);
      },
      (address) {
        updateFields(address);
      },
    );
  }

  void updateFields(AddressEntity entity) async {
    streetController.text = entity.street;
    numberController.text = entity.number;
    cityController.text = entity.city;
    stateController.text = entity.state;
    postalCodeController.text = entity.cep;
  }

  Future<ContactEntity> onButtonClick() async {
    isLoading.value = true;

    AddressEntity address = AddressEntity(
      street: streetController.text,
      number: numberController.text,
      city: cityController.text,
      state: stateController.text,
      cep: postalCodeController.text,
      lat: 0,
      lng: 0,
    );

    final latlng = await _doGetLatLngUsecase(address);

    latlng.fold(
      (failure) {
        print((failure as AddressFailure).message);
      },
      (latlng) {
        address = AddressEntity(
          street: streetController.text,
          number: numberController.text,
          city: cityController.text,
          state: stateController.text,
          cep: postalCodeController.text,
          lat: latlng[0],
          lng: latlng[1],
        );
      },
    );

    isLoading.value = false;

    final contact = ContactEntity(
      name: nameController.text,
      cpf: cpfController.text,
      phone: phoneController.text,
      address: address,
    );

    clearFields();

    Modular.to.pop();

    return contact;
  }

  void clearFields() {
    nameController.clear();
    cpfController.clear();
    phoneController.clear();
    streetController.clear();
    numberController.clear();
    cityController.clear();
    stateController.clear();
    postalCodeController.clear();
  }
}
