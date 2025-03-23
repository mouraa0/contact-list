class AuthCredentialsEntity {
  final String email;
  final String? password;

  AuthCredentialsEntity({required this.email, this.password});

  Map<String, dynamic> toMap() {
    return {'email': email, 'password': password};
  }
}
