import 'package:flutter/material.dart';
import '../theme/theme.dart';
class AppTitle extends StatelessWidget {
  final String text;
  const AppTitle(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
        color: Theme.of(context).colorScheme.outline,
        fontSize: 25
      ),
    );
  }
}
