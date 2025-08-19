import 'package:flutter/material.dart';
import 'package:tv_assassin/ui/assassin_button.dart';
import 'package:tv_assassin/ui/theme_toggle.dart';

class MainScreen extends StatelessWidget {
  final VoidCallback onAssassinButtonPressed;
  final VoidCallback onThemeTogglePressed;
  final bool isTransmitting;
  final String? errorMessage;

  const MainScreen({
    super.key,
    required this.onAssassinButtonPressed,
    required this.onThemeTogglePressed,
    this.isTransmitting = false,
    this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    // Show error message in a SnackBar if there is one
    if (errorMessage != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage!), backgroundColor: Colors.red),
        );
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('TV Assassin'),
        actions: [ThemeToggle(onToggle: onThemeTogglePressed)],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AssassinButton(
              onPressed: onAssassinButtonPressed,
              isTransmitting: isTransmitting,
            ),
            const SizedBox(height: 32),
            const Text(
              'Point your device at TVs and press the button',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
