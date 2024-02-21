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
        textTheme: TextTheme(
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            fixedSize: Size(MediaQuery.of(context).size.width / 2, 60),
            alignment: Alignment.center,
            backgroundColor: Color(0xFF22BB9C),
            textStyle: TextStyle(
              inherit: false,
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ),
        primaryColor: const Color(0xFF22BB9C),
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