import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String login;
  final String password;

  const UserModel({
    required this.login,
    required this.password,
  });

  @override
  List<Object> get props {
    return [login, password];
  }

  static const users = [
    UserModel(
      login: "root",
      password: "236122",
    ),
    UserModel(
      login: "agroinfo",
      password: "435346",
    ),
  ];
}
