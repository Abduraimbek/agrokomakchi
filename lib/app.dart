import 'package:agrokomakchi/pages/pages.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      theme: FlexThemeData.light(
        useMaterial3: true,
        useMaterial3ErrorColors: true,
        scheme: FlexScheme.green,
      ),
      builder: (context, child) {
        return _UnFocus(child: child!);
      },
      routes: _routes,
      initialRoute: homePage,
    );
  }

  final _routes = {
    homePage: (_) => const HomePage(),
    innerPage: (_) => const InnerPage(),
    pdfPage: (_) => const MyPdfPage(),
    loginPage: (_) => const LoginPage(),
  };

  static const homePage = "/homePage";
  static const innerPage = "/innerPage";
  static const pdfPage = "/pdfPage";
  static const loginPage = "/loginPage";
}

class _UnFocus extends StatelessWidget {
  const _UnFocus({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: child,
    );
  }
}
