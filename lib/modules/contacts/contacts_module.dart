import 'package:contact_list/modules/contacts/data/datasource/address_datasource.dart';
import 'package:contact_list/modules/contacts/data/datasource/contact_datasource.dart';
import 'package:contact_list/modules/contacts/data/repositories/address_repository.dart';
import 'package:contact_list/modules/contacts/data/repositories/contact_repository.dart';
import 'package:contact_list/modules/contacts/domain/repositories/i_address_repository.dart';
import 'package:contact_list/modules/contacts/domain/repositories/i_contact_repository.dart';
import 'package:contact_list/modules/contacts/domain/usecases/do_add_contact_usecase.dart';
import 'package:contact_list/modules/contacts/domain/usecases/do_delete_contact_usecase.dart';
import 'package:contact_list/modules/contacts/domain/usecases/do_get_address_details_usecase.dart';
import 'package:contact_list/modules/contacts/domain/usecases/do_get_autocomplete_address_usecase.dart';
import 'package:contact_list/modules/contacts/domain/usecases/do_get_contacts_usecase.dart';
import 'package:contact_list/modules/contacts/domain/usecases/do_get_lat_lng_usecase.dart';
import 'package:contact_list/modules/contacts/domain/usecases/do_update_contact_usecase.dart';
import 'package:contact_list/modules/contacts/presentation/controller/address_modal_controller.dart';
import 'package:contact_list/modules/contacts/presentation/controller/contact_page_controller.dart';
import 'package:contact_list/modules/contacts/presentation/pages/contact_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ContactsModule extends Module {
  void _datasources(Injector i) {
    i.addSingleton<ContactDatasource>(() => ContactDatasourceImpl());
    i.addSingleton<AddressDatasource>(() => AddressDatasourceImpl());
  }

  void _repositories(Injector i) {
    i.addSingleton<IContactRepository>(() => ContactRepository(i.get()));
    i.addSingleton<IAddressRepository>(() => AddressRepository(i.get()));
  }

  void _usecases(Injector i) {
    i.addSingleton<IDoGetAutocompleteAddressUsecase>(
      () => DoGetAutocompleteAddressUsecase(i.get()),
    );
    i.addSingleton<IDoDeleteContactUsecase>(
      () => DoDeleteContactUsecase(i.get()),
    );
    i.addSingleton<IDoAddContactUsecase>(() => DoAddContactUsecase(i.get()));
    i.addSingleton<IDoGetContactsUsecase>(() => DoGetContactsUsecase(i.get()));
    i.addSingleton<IDoUpdateContactUsecase>(
      () => DoUpdateContactUsecase(i.get()),
    );
    i.addSingleton<IDoGetAddressDetailsUsecase>(
      () => DoGetAddressDetailsUsecase(i.get()),
    );
    i.addSingleton<IDoGetLatLngUsecase>(() => DoGetLatLngUsecase(i.get()));
  }

  void _controllers(Injector i) {
    i.addSingleton<AddressModalController>(
      () => AddressModalController(i.get(), i.get(), i.get()),
    );
    i.addSingleton(() => ContactPageController(i.get(), i.get(), i.get()));
  }

  @override
  void binds(i) {
    _datasources(i);
    _repositories(i);
    _usecases(i);
    _controllers(i);
  }

  @override
  void routes(r) {
    r.child(
      '/',
      child:
          (context) =>
              ContactsPage(controller: Modular.get<ContactPageController>()),
    );
  }
}
