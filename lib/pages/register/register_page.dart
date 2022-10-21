import 'package:agrokomakchi/app.dart';
import 'package:agrokomakchi/providers/providers.dart';
import 'package:agrokomakchi/utils/utils.dart';
import 'package:flutter/material.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  ConsumerState createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  bool secured = true;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final buttonEnabled = ref.watch(registerProvider);

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  AppConsts.appName,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.length < 4) {
                      return AppConsts.lanValidator;
                    }
                    return null;
                  },
                  onChanged: ref.read(registerProvider.notifier).typeName,
                  decoration: const InputDecoration(
                    isDense: true,
                    prefixIcon: Icon(Icons.person_rounded),
                    border: OutlineInputBorder(),
                    hintText: "Исм",
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.length < 4) {
                      return AppConsts.lanValidator;
                    }
                    return null;
                  },
                  onChanged: ref.read(registerProvider.notifier).typeLogin,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    isDense: true,
                    prefixIcon: Icon(Icons.alternate_email_rounded),
                    border: OutlineInputBorder(),
                    hintText: "Логин",
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.length < 4) {
                      return AppConsts.lanValidator;
                    }
                    return null;
                  },
                  onChanged: ref.read(registerProvider.notifier).typePassword,
                  textInputAction: TextInputAction.done,
                  obscureText: secured,
                  decoration: InputDecoration(
                    isDense: true,
                    prefixIcon: const Icon(Icons.lock_rounded),
                    border: const OutlineInputBorder(),
                    hintText: "Парол",
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          secured = !secured;
                        });
                      },
                      icon: Icon(
                        !secured
                            ? Icons.visibility_off_rounded
                            : Icons.visibility_rounded,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: buttonEnabled
                      ? () {
                          if (formKey.currentState!.validate()) {
                            ref
                                .read(registerProvider.notifier)
                                .pressRegisterButton();
                          }
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                  ),
                  child: const Text("Рўйҳатдан ўтиш"),
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed(App.loginPage);
                  },
                  child: const Text("Логин"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
