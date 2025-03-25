import 'dart:convert';

import 'package:contact_list/core/error/failure.dart';
import 'package:contact_list/modules/auth/domain/entities/auth_entity.dart';
import 'package:contact_list/modules/contacts/data/models/contact_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ContactDatasource {
  Future<List<ContactModel>?> getContacts(AuthEntity user);
  Future<void> addContact(ContactModel contact, AuthEntity user);
  Future<void> deleteContact(ContactModel contact, AuthEntity user);
  Future<void> updateContact(ContactModel contact, AuthEntity user);
}

class ContactDatasourceImpl implements ContactDatasource {
  @override
  Future<List<ContactModel>?> getContacts(AuthEntity user) async {
    final preferences = await SharedPreferences.getInstance();
    final data = preferences.getString('contacts/${user.email}');

    if (data != null) {
      final contacts = json.decode(data) as List;
      return contacts.map((e) => ContactModel.fromMap(e)).toList();
    } else {
      throw ContactFailure(message: 'Not found');
    }
  }

  @override
  Future<void> addContact(ContactModel contact, AuthEntity user) async {
    final preferences = await SharedPreferences.getInstance();
    final data = preferences.getString('contacts/${user.email}');

    if (data != null) {
      final contacts = json.decode(data) as List;

      contacts.add(contact.toMap());
      await preferences.setString(
        'contacts/${user.email}',
        json.encode(contacts),
      );
    } else {
      await preferences.setString(
        'contacts/${user.email}',
        json.encode([contact.toMap()]),
      );
    }
  }

  @override
  Future<void> deleteContact(ContactModel contact, AuthEntity user) async {
    final preferences = await SharedPreferences.getInstance();
    final data = preferences.getString('contacts/${user.email}');

    if (data != null) {
      final contacts = json.decode(data) as List;

      contacts.removeWhere((element) => element['cpf'] == contact.cpf);
      await preferences.setString(
        'contacts/${user.email}',
        json.encode(contacts),
      );
    }
  }

  @override
  Future<void> updateContact(ContactModel contact, AuthEntity user) async {
    final preferences = await SharedPreferences.getInstance();
    final data = preferences.getString('contacts/${user.email}');

    if (data != null) {
      final contacts = json.decode(data) as List;

      final index = contacts.indexWhere(
        (element) => element['cpf'] == contact.cpf,
      );
      contacts[index] = contact.toMap();
      await preferences.setString(
        'contacts/${user.email}',
        json.encode(contacts),
      );
    }
  }
}
