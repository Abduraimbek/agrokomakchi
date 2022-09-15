import 'package:agrokomakchi/app.dart';
import 'package:agrokomakchi/providers/providers.dart';
import 'package:agrokomakchi/services/services.dart';
import 'package:agrokomakchi/utils/utils.dart';
import 'package:flutter/material.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConsts.appName),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BuildItem(
            onPressed: () {
              ref.read(innerProvider.notifier).selectEnum(InnerEnum.disease);
              Navigator.pushNamed(context, App.innerPage);
            },
            text: "КАСАЛЛИКЛАР",
          ),
          const SizedBox(height: 40),
          BuildItem(
            onPressed: () {
              ref.read(innerProvider.notifier).selectEnum(InnerEnum.pest);
              Navigator.pushNamed(context, App.innerPage);
            },
            text: "ЗАРАРКУНАНДАЛАР",
          ),
        ],
      ),
    );
  }
}

class BuildItem extends StatelessWidget {
  const BuildItem({
    Key? key,
    required this.onPressed,
    required this.text,
  }) : super(key: key);

  final VoidCallback onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Card(
        elevation: 3,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onPressed,
              child: SizedBox(
                height: size.height * .23,
                width: double.infinity,
                child: Center(
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
