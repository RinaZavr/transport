import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:transport/ui/auth/screens/auth_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        focusColor: Colors.black,
        textTheme: TextTheme(
          headlineLarge: const TextStyle(
            fontSize: 20,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w500,
          ),
          headlineSmall: TextStyle(
            fontSize: 18,
            color: Colors.grey[700],
          ),
          headlineMedium: const TextStyle(
            fontSize: 18,
          ),
          titleMedium: const TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
          bodySmall: const TextStyle(
            fontSize: 15,
            color: Colors.black,
          ),
          bodyMedium: const TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
          bodyLarge: const TextStyle(
            fontSize: 15,
            color: Colors.black,
          ),
        ),
        primaryColor: const Color(0xFF22BB9C),
        hintColor: Colors.grey,
      ),
      home: AnimatedSplashScreen(
        backgroundColor: const Color(0xFF22BB9C),
        duration: 1000,
        splash: const Icon(Icons.travel_explore_rounded, size: 100,),
        nextScreen: const AuthScreen(),
      ),
    );
  }
}