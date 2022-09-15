import 'dart:io';

import 'package:agrokomakchi/app.dart';
import 'package:agrokomakchi/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  HttpOverrides.global = _My();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await Future.wait([
    HiveService().initialize(),
  ]);

  runApp(ProviderScope(child: App()));
}

class _My extends HttpOverrides {
  @override
  HttpClient createHttpClient(context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (cert, host, port) => true;
  }
}
