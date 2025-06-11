import 'package:flutter/material.dart';
import 'package:guidehogwarts/screens/welcome_screen.dart';
import 'package:guidehogwarts/theme/app_colors.dart';

void main() {
  runApp(const HogwartsGuideApp());
}

class HogwartsGuideApp extends StatelessWidget {
  const HogwartsGuideApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hogwarts Guide',
      theme: ThemeData(
        primarySwatch: Colors.brown,
        scaffoldBackgroundColor: AppColors.cream,
        fontFamily: 'serif', // Usando uma fonte com serifa para um visual mais clássico.
      ),
      home: const WelcomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}