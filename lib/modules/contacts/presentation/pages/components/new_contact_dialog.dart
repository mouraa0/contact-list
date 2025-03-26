import 'package:brasil_fields/brasil_fields.dart';
import 'package:contact_list/core/constants/app_constants.dart';
import 'package:contact_list/core/validator/input_validator.dart';
import 'package:contact_list/core/widgets/buttons/submit_button.dart';
import 'package:contact_list/core/widgets/input/input_field.dart';
import 'package:contact_list/modules/contacts/domain/entities/autocomplete_address_entity.dart';
import 'package:contact_list/modules/contacts/domain/entities/contact_entity.dart';
import 'package:contact_list/modules/contacts/presentation/controller/address_modal_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class NewContactDialog extends StatelessWidget {
  final Object object;
  final void Function(ContactEntity) onAddContact;

  final _formKey = GlobalKey<FormState>();

  NewContactDialog({
    super.key,
    required this.object,
    required this.onAddContact,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Modular.get<AddressModalController>();

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Form(
          key: _formKey,
          child: Column(
            spacing: 16,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Contato',
                style: TextStyle(
                  fontSize: AppConstants.headingSmallerFontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              InputField(
                headerText: 'Nome',
                controller: controller.nameController,
                hintText: 'João da Silva',
                validator: InputValidator.validateRequiredField,
              ),
              Row(
                spacing: 10,
                children: [
                  Expanded(
                    child: InputField(
                      headerText: 'CPF',
                      hintText: '000.000.000-00',
                      controller: controller.cpfController,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(11),
                        CpfInputFormatter(),
                      ],
                      validator: InputValidator.validateCPF,
                    ),
                  ),
                  Expanded(
                    child: InputField(
                      headerText: 'Telefone',
                      hintText: '(00) 00000-0000',
                      controller: controller.phoneController,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(11),
                        TelefoneInputFormatter(),
                      ],
                      validator: InputValidator.validatePhone,
                    ),
                  ),
                ],
              ),
              _AddressForm(
                formKey: _formKey,
                controller: controller,
                onAddContact: onAddContact,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AddressForm extends StatelessWidget {
  final GlobalKey<FormState> _formKey;
  final AddressModalController controller;
  final void Function(ContactEntity) onAddContact;

  const _AddressForm({
    required GlobalKey<FormState> formKey,
    required this.controller,
    required this.onAddContact,
  }) : _formKey = formKey;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () =>
          controller.isLoading.value
              ? SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                ),
              )
              : Column(
                spacing: 16,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Endereço',
                    style: TextStyle(
                      fontSize: AppConstants.headingSmallerFontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TypeAheadField<AutocompleteAddressEntity>(
                    suggestionsCallback: controller.onSearchChanged,
                    loadingBuilder: (context) => const Text('Loading...'),
                    builder: (context, controller, focusNode) {
                      return InputField(
                        prefix: Icons.search,
                        hintText: 'Buscar Endereço',
                        focusNode: focusNode,
                        controller: controller,
                      );
                    },
                    itemBuilder: (context, address) {
                      return ListTile(title: Text(address.description));
                    },
                    onSelected: controller.onAutocompleteSelected,
                  ),
                  InputField(
                    headerText: 'Logradouro',
                    hintText: 'Rua das Flores',
                    controller: controller.streetController,
                    validator: InputValidator.validateRequiredField,
                  ),
                  Row(
                    spacing: 10,
                    children: [
                      Expanded(
                        child: InputField(
                          headerText: 'Número',
                          controller: controller.numberController,
                          hintText: 'S/N',
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(5),
                          ],
                          validator: InputValidator.validateRequiredField,
                        ),
                      ),
                      Expanded(
                        child: InputField(
                          headerText: 'Complemento',
                          hintText: 'Apto 101',
                        ),
                      ),
                    ],
                  ),
                  InputField(
                    headerText: 'Cidade',
                    controller: controller.cityController,
                    hintText: 'São Paulo',
                    validator: InputValidator.validateRequiredField,
                  ),
                  Row(
                    spacing: 10,
                    children: [
                      Expanded(
                        child: InputField(
                          headerText: 'UF',
                          controller: controller.stateController,
                          hintText: 'SP',
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp(r'[a-zA-Z]'),
                            ),
                            LengthLimitingTextInputFormatter(2),
                          ],
                          validator: InputValidator.validateUF,
                        ),
                      ),
                      Expanded(
                        child: InputField(
                          headerText: 'CEP',
                          controller: controller.postalCodeController,
                          hintText: '00000-000',
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(8),
                            CepInputFormatter(ponto: false),
                          ],
                          validator: InputValidator.validateCEP,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  SizedBox(
                    width: double.infinity,
                    child: SubmitButton(
                      formKey: _formKey,
                      text: 'Salvar Contato',
                      onSubmit: () async {
                        if (_formKey.currentState?.validate() ?? false) {
                          final contact = await controller.onButtonClick();

                          onAddContact(contact);
                        }
                      },
                    ),
                  ),
                ],
              ),
    );
  }
}
