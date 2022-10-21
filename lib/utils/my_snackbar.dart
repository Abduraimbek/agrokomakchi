import 'package:agrokomakchi/app.dart';
import 'package:flutter/material.dart';

showMySnackBar(String msg) {
  ScaffoldMessenger.of(navigatorKey.currentState!.context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(msg)));
}
