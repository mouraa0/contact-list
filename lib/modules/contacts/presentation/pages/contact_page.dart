import 'package:contact_list/core/constants/app_constants.dart';
import 'package:contact_list/modules/contacts/presentation/controller/contact_page_controller.dart';
import 'package:contact_list/modules/contacts/presentation/pages/components/map_view.dart';
import 'package:contact_list/modules/contacts/presentation/pages/components/new_contact_dialog.dart';
import 'package:flutter/material.dart';

class ContactsPage extends StatefulWidget {
  final ContactPageController controller;
  const ContactsPage({super.key, required this.controller});

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  @override
  void initState() {
    widget.controller.initContactPage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(flex: 1, child: _Sidebar(widget.controller)),
          Expanded(
            flex: 3,
            child: Column(children: [_Topbar(), Expanded(child: MapView())]),
          ),
        ],
      ),
    );
  }
}

class _Sidebar extends StatelessWidget {
  final ContactPageController controller;

  const _Sidebar(this.controller);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(
            color: Theme.of(context).colorScheme.secondary,
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          Container(
            height: AppConstants.frameHeight,
            padding: EdgeInsets.all(AppConstants.defaultPadding),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Theme.of(context).colorScheme.secondary,
                  width: 1,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Contacts",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () => _showFormModal(context, controller),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          // Expanded(child: ContactList()),
        ],
      ),
    );
  }

  void _showFormModal(BuildContext context, ContactPageController controller) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.borderRadius),
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 500),
            child: NewContactDialog(
              object: {},
              onAddContact: controller.addContact,
            ),
          ),
        );
      },
    );
  }
}

class _Topbar extends StatelessWidget {
  const _Topbar();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppConstants.frameHeight,
      width: double.infinity,
      padding: EdgeInsets.all(AppConstants.defaultPadding),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).colorScheme.secondary,
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Map",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          _UserAvatar(),
        ],
      ),
    );
  }
}

class _UserAvatar extends StatelessWidget {
  const _UserAvatar();

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (value) {
        if (value == 'delete') {
          const snackBar = SnackBar(
            content: Text('Conta deletada com sucesso!'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else if (value == 'logout') {
          const snackBar = SnackBar(
            content: Text('Sessão encerrada com sucesso!'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      itemBuilder:
          (BuildContext context) => [
            PopupMenuItem(
              value: 'delete',
              child: Row(
                spacing: 8,
                children: [
                  Icon(
                    Icons.delete,
                    color: Theme.of(context).colorScheme.error,
                  ),
                  Text('Deletar Conta'),
                ],
              ),
            ),
            PopupMenuItem(
              value: 'logout',
              child: Row(
                spacing: 8,
                children: [
                  Icon(
                    Icons.exit_to_app,
                    color: Theme.of(context).primaryColor,
                  ),
                  Text('Sair da Conta'),
                ],
              ),
            ),
          ],
      child: CircleAvatar(
        radius: 24,
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: Icon(
          Icons.person,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
    );
  }
}
