import 'package:brasil_fields/brasil_fields.dart';
import 'package:contact_list/core/constants/app_constants.dart';
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
                hintText: 'João da Silva',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Este campo é obrigatório';
                  }
                  return null;
                },
              ),
              Row(
                spacing: 10,
                children: [
                  Expanded(
                    child: InputField(
                      headerText: 'CPF',
                      hintText: '000.000.000-00',
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(11),
                        CpfInputFormatter(),
                      ],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Este campo é obrigatório';
                        } else if (!RegExp(
                          r'^\d{3}\.\d{3}\.\d{3}-\d{2}$',
                        ).hasMatch(value)) {
                          return 'CPF inválido. O formato deve ser XXX.XXX.XXX-XX';
                        } else if (!CPFValidator.isValid(value)) {
                          return 'CPF inválido. Verifique os dados informados';
                        }
                        return null;
                      },
                    ),
                  ),
                  Expanded(
                    child: InputField(
                      headerText: 'Telefone',
                      hintText: '(00) 00000-0000',
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(11),
                        TelefoneInputFormatter(),
                      ],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Este campo é obrigatório';
                        } else if (!RegExp(
                          r'^\(\d{2}\) \d{5}-\d{4}$',
                        ).hasMatch(value)) {
                          return 'Telefone inválido. O formato deve ser (XX) XXXXX-XXXX';
                        }
                        return null;
                      },
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
                      return TextField(
                        focusNode: focusNode,
                        controller: controller,
                        autofocus: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'City',
                        ),
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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Este campo é obrigatório';
                      }
                      return null;
                    },
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Este campo é obrigatório';
                            }
                            return null;
                          },
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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Este campo é obrigatório';
                      }
                      return null;
                    },
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Este campo é obrigatório';
                            } else if (value.length != 2) {
                              return 'UF inválida. Deve ter 2 caracteres';
                            }
                            return null;
                          },
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Este campo é obrigatório';
                            } else if (!RegExp(
                              r'^\d{5}-\d{3}$',
                            ).hasMatch(value)) {
                              return 'CEP inválido. O formato deve ser XXXXX-XXX';
                            }
                            return null;
                          },
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
