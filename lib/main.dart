import 'package:flutter/material.dart';
import 'package:shop_app_flutter/core/managers/theme_manager.dart';
import 'package:shop_app_flutter/modules/on_boarding_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: darkTheme,
      theme: lightTheme,
      themeMode: ThemeMode.light,
      home: OnBoardingScreen(),
    );
  }
}
