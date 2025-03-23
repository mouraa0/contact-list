class InputValidator {
  static String? validateEmail(value) {
    if (value == null || value.isEmpty) {
      return 'Este campo é obrigatório';
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
    if (value == null || value.isEmpty) {
      return 'Este campo é obrigatório';
    }

    return null;
  }
}
