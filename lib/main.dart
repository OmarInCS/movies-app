import 'package:flutter/material.dart';
import 'package:movies_app/constants/app_theme.dart';
import 'package:movies_app/screens/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: darkTheme,
      home: MainScreen(),
    );
  }
}
