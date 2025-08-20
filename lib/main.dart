import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv_assassin/ui/main_screen.dart';
import 'package:tv_assassin/utils/security_utils.dart';
import 'package:tv_assassin/viewmodel/main_view_model.dart';
import 'package:tv_assassin/viewmodel/theme_manager.dart';

void main() {
  // Security check for release mode flags
  SecurityUtils.checkReleaseModeFlags();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeManager>(
          create: (_) => ThemeManager()..init(),
        ),
        ChangeNotifierProvider<MainViewModel>(create: (_) => MainViewModel()),
      ],
      child: Consumer<ThemeManager>(
        builder: (context, themeManager, child) {
          return MaterialApp(
            title: 'TV Assassin',
            theme: ThemeData(
              primarySwatch: Colors.purple,
              brightness: Brightness.light,
            ),
            darkTheme: ThemeData(
              primarySwatch: Colors.purple,
              brightness: Brightness.dark,
            ),
            themeMode: themeManager.currentTheme,
            home: const MyHomePage(),
          );
        },
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);
    final viewModel = Provider.of<MainViewModel>(context);

    return MainScreen(
      onAssassinButtonPressed: viewModel.transmitAllShutdownCodes,
      onThemeTogglePressed: themeManager.toggleTheme,
      isTransmitting: viewModel.isTransmitting,
      errorMessage: viewModel.errorMessage,
    );
  }
}
