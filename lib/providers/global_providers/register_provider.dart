import 'dart:convert';

import 'package:agrokomakchi/app.dart';
import 'package:agrokomakchi/services/services.dart';
import 'package:agrokomakchi/utils/my_connectivity_checker.dart';
import 'package:agrokomakchi/utils/my_message_dialog.dart';
import 'package:agrokomakchi/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;

final registerProvider =
    StateNotifierProvider.autoDispose<RegisterNotifier, bool>((ref) {
  return RegisterNotifier();
});

class RegisterNotifier extends StateNotifier<bool> {
  RegisterNotifier() : super(true);

  String name = "";
  String login = "";
  String password = "";

  void typeName(String value) {
    name = value;
  }

  void typeLogin(String value) {
    login = value;
  }

  void typePassword(String value) {
    password = value;
  }

  Future<void> pressRegisterButton() async {
    state = false;

    final internet = await myCheckConnection();
    if (!internet) {
      state = true;
      return;
    }

    showMyWaitingDialog();

    try {
      final response = await http.post(
        Uri.parse("${AppConsts.baseUrl}signUpAK"),
        headers: AppConsts.headers,
        body: jsonEncode({
          "full_name": name,
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
