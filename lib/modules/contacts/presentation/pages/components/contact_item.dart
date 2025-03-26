import 'package:contact_list/modules/contacts/domain/entities/contact_entity.dart';
import 'package:flutter/material.dart';

class ContactItem extends StatelessWidget {
  final ContactEntity contact;
  final VoidCallback onTap;

  const ContactItem({super.key, required this.contact, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(contact.name),
      subtitle: Text(contact.cpf),
      onTap: onTap,
    );
  }
}
