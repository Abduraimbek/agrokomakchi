import 'package:agrokomakchi/app.dart';
import 'package:flutter/material.dart';

showMyMessageDialog(String message) {
  showDialog(
    context: navigatorKey.currentState!.context,
    builder: (context) {
      return AlertDialog(
        contentPadding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
        title: Text(
          message,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("         ОК         "),
          ),
        ],
      );
    },
  );
}

showMyWaitingDialog() {
  showDialog(
    context: navigatorKey.currentState!.context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        content: SizedBox(
          height: MediaQuery.of(context).size.height * .1,
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    },
  );
}
