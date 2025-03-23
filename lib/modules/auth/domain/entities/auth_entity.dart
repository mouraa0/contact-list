import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final String email;

  const AuthEntity({required this.email});

  @override
  List<Object> get props => [email];
}
