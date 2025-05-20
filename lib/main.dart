import 'package:flutter/material.dart';
import 'screens/generateur_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GenerateurScreen(),
      theme: ThemeData(
        fontFamily: 'CrimsonPro', // à ajouter aussi
        scaffoldBackgroundColor: Colors.transparent,
      ),
    );
  }
}
