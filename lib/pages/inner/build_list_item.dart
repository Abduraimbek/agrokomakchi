import 'package:agrokomakchi/services/services.dart';
import 'package:flutter/material.dart';

class BuildListItem extends StatelessWidget {
  const BuildListItem({
    Key? key,
    required this.onPressed,
    required this.model,
  }) : super(key: key);

  final VoidCallback onPressed;
  final InnerModel model;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
      onTap: onPressed,
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.asset(
          model.imagePath,
          width: size.width * .22,
          fit: BoxFit.cover,
        ),
      ),
      title: Text(model.title),
    );
  }
}
