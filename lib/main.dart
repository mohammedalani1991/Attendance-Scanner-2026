import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'screens/home_screen.dart';

void main() async {
  // Required before any native plugin uses platform channels
  WidgetsFlutterBinding.ensureInitialized();

  // Catch uncaught Dart/Flutter errors and show them on screen
  // so crashes are visible without needing ADB logcat
  runZonedGuarded(
    () {
      FlutterError.onError = FlutterError.presentError;
      runApp(const ProviderScope(child: AttendanceScannerApp()));
    },
    (error, stack) {
      runApp(_CrashScreen(error: error.toString(), stack: stack.toString()));
    },
  );
}

/// Shown instead of a silent close when an uncaught Dart error occurs.
/// Remove this widget once the app is stable.
class _CrashScreen extends StatelessWidget {
  const _CrashScreen({required this.error, required this.stack});
  final String error;
  final String stack;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.red.shade900,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('CRASH',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  Text(error,
                      style:
                          const TextStyle(color: Colors.white, fontSize: 13)),
                  const SizedBox(height: 16),
                  Text(stack,
                      style: const TextStyle(
                          color: Colors.white70, fontSize: 10)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AttendanceScannerApp extends StatelessWidget {
  const AttendanceScannerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ماسح الحضور',
      debugShowCheckedModeBanner: false,
      // Set app to Arabic language with RTL support
      locale: const Locale('ar'),
      supportedLocales: const [Locale('ar')],
      // Add localization delegates for RTL support
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData(
        // Color scheme
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
        useMaterial3: true,

        // AppBar theme
        appBarTheme: const AppBarTheme(
          centerTitle: false,
          elevation: 0,
        ),

        // Card theme
        cardTheme: CardThemeData(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),

        // Input decoration theme
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          filled: true,
        ),

        // Button themes
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),

        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),

        // Floating action button theme
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          elevation: 4,
        ),
      ),

      // Dark theme (optional)
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),

      // Set the home screen
      home: const HomeScreen(),
    );
  }
}
