import 'package:contact_list/modules/auth/domain/entities/auth_entity.dart';

class AuthModel extends AuthEntity {
  const AuthModel({required super.email});

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(email: json['email']);
  }
}
