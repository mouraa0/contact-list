abstract class Failure implements Exception {}

class AuthFailure implements Failure {
  final String message;

  AuthFailure({required this.message});
}

class ContactFailure implements Failure {
  final String message;

  ContactFailure({required this.message});
}

class AddressFailure implements Failure {
  final String message;

  AddressFailure({required this.message});
}
