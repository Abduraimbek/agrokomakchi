import 'dart:convert';

import 'package:agrokomakchi/app.dart';
import 'package:agrokomakchi/services/services.dart';
import 'package:agrokomakchi/utils/my_connectivity_checker.dart';
import 'package:agrokomakchi/utils/my_message_dialog.dart';
import 'package:agrokomakchi/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;

final loginProvider =
    StateNotifierProvider.autoDispose<LoginNotifier, bool>((ref) {
  return LoginNotifier();
});

class LoginNotifier extends StateNotifier<bool> {
  LoginNotifier() : super(true);

  String login = "";
  String password = "";

  void typeLogin(String value) {
    login = value;
  }

  void typePassword(String value) {
    password = value;
  }

  Future<void> pressLoginButton() async {
    state = false;

    final internet = await myCheckConnection();
    if (!internet) {
      state = true;
      return;
    }

    showMyWaitingDialog();

    try {
      final response = await http.post(
        Uri.parse("${AppConsts.baseUrl}signInAK"),
        headers: AppConsts.headers,
        body: jsonEncode({
          "login": login,
          "password": password,
        }),
      );
      final parsed = jsonDecode(utf8.decode(response.bodyBytes));

      Navigator.of(navigatorKey.currentState!.context).pop();

      if (parsed["code"] == 0) {
        await HiveService().saveIsRegistered(true);
        await HiveService().saveIntUserId(parsed["data"]["id"]);
        Navigator.of(navigatorKey.currentState!.context)
            .pushReplacementNamed(App.homePage);
      } else {
        showMyMessageDialog(parsed["message"].toString());
        state = true;
      }
    } catch (e) {
      Navigator.of(navigatorKey.currentState!.context).pop();
      showMyMessageDialog("$e");
    }
  }
}
