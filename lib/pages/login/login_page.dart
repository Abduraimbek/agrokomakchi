import 'package:agrokomakchi/providers/providers.dart';
import 'package:agrokomakchi/utils/utils.dart';
import 'package:flutter/material.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  ConsumerState createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  late TextEditingController loginController;
  late TextEditingController passwordController;
  late FocusNode loginFocusNode;
  late FocusNode passwordFocusNode;

  bool _isSecured = true;

  @override
  void initState() {
    super.initState();

    loginController = TextEditingController();
    passwordController = TextEditingController();

    loginFocusNode = FocusNode();
    passwordFocusNode = FocusNode();

    loginFocusNode.addListener(_loginListener);
    passwordFocusNode.addListener(_passwordListener);
  }

  @override
  void dispose() {
    super.dispose();

    loginController.dispose();
    passwordController.dispose();

    loginFocusNode.removeListener(_loginListener);
    passwordFocusNode.removeListener(_passwordListener);

    loginFocusNode.dispose();
    passwordFocusNode.dispose();
  }

  void _loginListener() {
    if (loginFocusNode.hasFocus) {
      loginController.selection = TextSelection(
        baseOffset: 0,
        extentOffset: loginController.text.length,
      );
    }
  }

  void _passwordListener() {
    if (passwordFocusNode.hasFocus) {
      passwordController.selection = TextSelection(
        baseOffset: 0,
        extentOffset: passwordController.text.length,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final buttonEnabled = ref.watch(loginProvider);

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppConsts.appName,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: loginController,
                focusNode: loginFocusNode,
                onChanged: ref.read(loginProvider.notifier).typeLogin,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  isDense: true,
                  prefixIcon: Icon(Icons.person_rounded),
                  border: OutlineInputBorder(),
                  hintText: "Логин",
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: passwordController,
                focusNode: passwordFocusNode,
                onChanged: ref.read(loginProvider.notifier).typePassword,
                textInputAction: TextInputAction.done,
                obscureText: _isSecured,
                decoration: InputDecoration(
                  isDense: true,
                  prefixIcon: const Icon(Icons.lock_rounded),
                  border: const OutlineInputBorder(),
                  hintText: "Парол",
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _isSecured = !_isSecured;
                      });
                    },
                    icon: Icon(
                      !_isSecured
                          ? Icons.visibility_off_rounded
                          : Icons.visibility_rounded,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: buttonEnabled
                    ? ref.read(loginProvider.notifier).pressLoginButton
                    : null,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                ),
                child: const Text("Кириш"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
