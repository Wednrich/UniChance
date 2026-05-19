import 'package:flutter/material.dart';

import 'screens/about_screen.dart';
import 'screens/grant_check_screen.dart';
import 'screens/home_screen.dart';
import 'screens/programs_screen.dart';
import 'screens/universities_screen.dart';

void main() {
  runApp(const UniChanceApp());
}

class UniChanceApp extends StatelessWidget {
  const UniChanceApp({super.key});

  static const primaryTeal = Color(0xFF07848C);
  static const background = Color(0xFFF7FAFA);
  static const textColor = Color(0xFF172033);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UniChance',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: background,
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryTeal,
          primary: primaryTeal,
          surface: Colors.white,
          outline: const Color(0xFFE2E8F0),
        ),
        textTheme: Theme.of(
          context,
        ).textTheme.apply(bodyColor: textColor, displayColor: textColor),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: primaryTeal, width: 1.7),
          ),
          labelStyle: const TextStyle(
            color: Color(0xFF6B7280),
            fontWeight: FontWeight.w700,
          ),
          hintStyle: const TextStyle(color: Color(0xFF94A3B8)),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 18,
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (_) => const HomeScreen(),
        '/grant': (_) => const GrantCheckScreen(),
        '/universities': (_) => const UniversitiesScreen(),
        '/programs': (_) => const ProgramsScreen(),
        '/about': (_) => const AboutScreen(),
      },
    );
  }
}
