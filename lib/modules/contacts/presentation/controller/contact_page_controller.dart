import 'package:contact_list/core/error/failure.dart';
import 'package:contact_list/core/service/user_service.dart';
import 'package:contact_list/modules/contacts/domain/entities/contact_entity.dart';
import 'package:contact_list/modules/contacts/domain/usecases/do_add_contact_usecase.dart';
import 'package:contact_list/modules/contacts/domain/usecases/do_get_contacts_usecase.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/state_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ContactPageController extends GetxController {
  final IDoGetContactsUsecase _doGetContactsUsecase;
  final IDoAddContactUsecase _doAddContactUsecase;

  ContactPageController(this._doAddContactUsecase, this._doGetContactsUsecase);

  RxList<ContactEntity> contacts = <ContactEntity>[].obs;

  RxBool isLoading = false.obs;

  GoogleMapController? mapController;

  void initContactPage() {
    final userService = Modular.get<UserService>();

    if (!userService.isLogged()) {
      Modular.to.popAndPushNamed('/');
    }

    getContacts();
  }

  void addContact(ContactEntity contact) async {
    isLoading.value = true;

    final userService = Modular.get<UserService>();

    final result = await _doAddContactUsecase(contact, userService.user!);

    result.fold(
      (failure) {
        print((failure as ContactFailure).message);
      },
      (success) {
        getContacts();
      },
    );
  }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void onContactClicked(ContactEntity contact) async {
    final CameraPosition pos = CameraPosition(
      target: LatLng(contact.address.lat, contact.address.lng),
      zoom: 18,
    );

    await mapController!.animateCamera(CameraUpdate.newCameraPosition(pos));
  }

  void getContacts() async {
    final userService = Modular.get<UserService>();

    final result = await _doGetContactsUsecase(userService.user!);

    result?.fold(
      (failure) {
        print((failure as ContactFailure).message);
      },
      (contacts) {
        this.contacts.value = contacts;
      },
    );
  }
}
