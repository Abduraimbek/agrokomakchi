import 'dart:convert';

import 'package:agrokomakchi/app.dart';
import 'package:agrokomakchi/providers/providers.dart';
import 'package:agrokomakchi/services/services.dart';
import 'package:agrokomakchi/utils/my_connectivity_checker.dart';
import 'package:agrokomakchi/utils/my_message_dialog.dart';
import 'package:agrokomakchi/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConsts.appName),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              BuildItem(
                onPressed: () {
                  ref
                      .read(innerProvider.notifier)
                      .selectEnum(InnerEnum.disease);
                  Navigator.pushNamed(context, App.innerPage);
                },
                text: "КАСАЛЛИКЛАР",
              ),
              const SizedBox(height: 20),
              BuildItem(
                onPressed: () {
                  ref.read(innerProvider.notifier).selectEnum(InnerEnum.pest);
                  Navigator.pushNamed(context, App.innerPage);
                },
                text: "ЗАРАРКУНАНДАЛАР",
              ),
              const BuildCallInspector(),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

class BuildItem extends StatelessWidget {
  const BuildItem({
    Key? key,
    required this.onPressed,
    required this.text,
    this.isElevatedButton = false,
  }) : super(key: key);

  final VoidCallback onPressed;
  final String text;
  final bool isElevatedButton;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery
        .of(context)
        .size;

    return Card(
      elevation: 3,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onPressed,
            child: SizedBox(
              height: isElevatedButton ? null : size.height * .18,
              width: double.infinity,
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: isElevatedButton ? 15 : 0,
                  ),
                  child: Text(
                    text,
                    style: theme.textTheme.titleMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BuildCallInspector extends StatefulHookConsumerWidget {
  const BuildCallInspector({Key? key}) : super(key: key);

  @override
  ConsumerState createState() => _BuildCallInspectorState();
}

class _BuildCallInspectorState extends ConsumerState<BuildCallInspector> {
  final formKey = GlobalKey<FormState>();
  late TextEditingController controller;
  bool buttonEnabled = true;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 50),
          TextFormField(
            validator: (value) {
              if (value == null || value.length < 9) {
                return "Телефон рақами нотўғри";
              }
              return null;
            },
            controller: controller,
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.done,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              isDense: true,
              prefixIcon: Icon(Icons.phone_rounded),
              prefixText: "+998 ",
            ),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(9),
            ],
          ),
          const SizedBox(height: 20),
          BuildItem(
            onPressed: onBtnPressed,
            text: "Инспектор Чақириш",
            isElevatedButton: true,
          ),
        ],
      ),
    );
  }

  Future<void> onBtnPressed() async {
    if (formKey.currentState!.validate()) {
      final internet = await myCheckConnection();
      if (!internet) return;

      setState(() {
        buttonEnabled = false;
      });

      showMyWaitingDialog();

      Logger().e(SavedData.intUserId);

      try {
        final response = await http.post(
          Uri.parse("${AppConsts.baseUrl}callInspector"),
          headers: AppConsts.headers,
          body: jsonEncode({
            "user": SavedData.intUserId,
            "phone": controller.text,
          }),
        );
        final parsed = jsonDecode(utf8.decode(response.bodyBytes));
        if (parsed["code"] == 0) {
          Navigator.of(navigatorKey.currentState!.context).pop();
          showMyMessageDialog("Сўров амалга оширилди");
          controller.clear();
        } else {
          Navigator.of(navigatorKey.currentState!.context).pop();
          showMyMessageDialog(parsed["message"]);
        }
      } catch (e) {
        Navigator.of(navigatorKey.currentState!.context).pop();
        showMyMessageDialog("$e");
      }
    }

    setState(() {
      buttonEnabled = true;
    });
  }
}
