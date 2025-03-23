abstract class Failure implements Exception {}

class AuthFailure implements Failure {
  final String message;

  AuthFailure({required this.message});
}
