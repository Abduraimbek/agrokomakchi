import 'package:agrokomakchi/app.dart';
import 'package:agrokomakchi/services/services.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:collection/collection.dart';

final loginProvider =
    StateNotifierProvider.autoDispose<LoginNotifier, bool>((ref) {
  return LoginNotifier();
});

class LoginNotifier extends StateNotifier<bool> {
  LoginNotifier() : super(false);

  String login = "";
  String password = "";

  void _checkState() {
    state = login.length > 3 && password.length > 3;
  }

  void typeLogin(String value) {
    login = value;
    _checkState();
  }

  void typePassword(String value) {
    password = value;
    _checkState();
  }

  void pressLoginButton() {
    final user = UserModel.users.firstWhereOrNull((e) => e.login == login);

    if (user == null) {
      _showSnackBar("Нотўғри логин киритилди");
      return;
    }

    if (user.password != password) {
      _showSnackBar("Нотўғри парол киритилди");
      return;
    }

    HiveService().saveIsRegistered(true);
    Navigator.pushReplacementNamed(
      navigatorKey.currentState!.context,
      App.homePage,
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(navigatorKey.currentState!.context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }
}
