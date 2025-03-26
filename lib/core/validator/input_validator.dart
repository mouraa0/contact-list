import 'package:brasil_fields/brasil_fields.dart';

class InputValidator {
  static String? validateEmail(value) {
    final requiredFieldError = validateRequiredField(value);

    if (requiredFieldError != null) {
      return requiredFieldError;
    }

    if (value.length < 3) {
      return 'Deve ter pelo menos 3 caracteres';
    }

    if (value.length > 20) {
      return 'Deve ter menos de 20 caracteres';
    }

    if (value.contains('@') == false) {
      return 'Deve ser um email válido';
    }

    return null;
  }

  static String? validatePassword(value) {
    return validateRequiredField(value);
  }

  static String? validateCPF(value) {
    final requiredFieldError = validateRequiredField(value);

    if (requiredFieldError != null) {
      return requiredFieldError;
    }

    if (!CPFValidator.isValid(value)) {
      return 'CPF inválido. Verifique os dados informados';
    }

    return null;
  }

  static String? validatePhone(value) {
    final requiredFieldError = validateRequiredField(value);

    if (requiredFieldError != null) {
      return requiredFieldError;
    }

    return null;
  }

  static String? validateUF(value) {
    final requiredFieldError = validateRequiredField(value);

    if (requiredFieldError != null) {
      return requiredFieldError;
    }

    if (value.length != 2) {
      return 'Deve ter 2 caracteres';
    }

    return null;
  }

  static String? validateCEP(value) {
    final requiredFieldError = validateRequiredField(value);

    if (requiredFieldError != null) {
      return requiredFieldError;
    }

    if (!RegExp(r'^\d{5}-\d{3}$').hasMatch(value)) {
      return 'CEP inválido. O formato deve ser XXXXX-XXX';
    }

    return null;
  }

  static String? validateRequiredField(value) {
    if (value == null || value.isEmpty) {
      return 'Este campo é obrigatório';
    }

    return null;
  }
}
