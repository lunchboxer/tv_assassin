import 'package:flutter/material.dart';

class ThemeToggle extends StatelessWidget {
  final VoidCallback onToggle;

  const ThemeToggle({super.key, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Toggle theme',
      button: true,
      child: IconButton(
        icon: Icon(
          Theme.of(context).brightness == Brightness.dark
              ? Icons.light_mode
              : Icons.dark_mode,
        ),
        onPressed: onToggle,
        tooltip: 'Toggle theme',
      ),
    );
  }
}
