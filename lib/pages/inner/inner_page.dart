import 'package:agrokomakchi/app.dart';
import 'package:agrokomakchi/providers/providers.dart';
import 'package:agrokomakchi/services/services.dart';
import 'package:flutter/material.dart';

import 'build_list_item.dart';

class InnerPage extends ConsumerWidget {
  const InnerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final innerState = ref.watch(innerProvider);

    final list = InnerModel.list
        .where((e) => e.innerEnum == innerState.innerEnum)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          innerState.innerEnum == InnerEnum.disease
              ? "КАСАЛЛИКЛАР"
              : "ЗАРАРКУНАНДАЛАР",
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 20),
        itemCount: list.length,
        itemBuilder: (context, index) {
          final model = list[index];

          return BuildListItem(
            onPressed: () {
              ref.read(innerProvider.notifier).selectModel(model);
              Navigator.pushNamed(context, App.pdfPage);
            },
            model: model,
          );
        },
        separatorBuilder: (_, __) {
          return const Divider(
            height: 1,
            thickness: 1,
          );
        },
      ),
    );
  }
}
