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

  RxSet<Marker> markers = <Marker>{}.obs;

  RxBool isLoading = false.obs;

  GoogleMapController? mapController;

  void initContactPage() {
    final userService = Modular.get<UserService>();

    if (!userService.isLogged()) {
      Future.delayed(const Duration(milliseconds: 100), () {
        Modular.to.popAndPushNamed('/');
      });

      return;
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

  void logout() {
    final userService = Modular.get<UserService>();

    userService.logout();
  }

  void onContactClicked(ContactEntity contact) async {
    final latLng = LatLng(contact.address.lat, contact.address.lng);

    final CameraPosition pos = CameraPosition(target: latLng, zoom: 18);

    markers.clear();

    markers.add(
      Marker(
        markerId: MarkerId(
          'marker_${contact.address.lat}_${contact.address.lng}',
        ),
        position: latLng,
      ),
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
