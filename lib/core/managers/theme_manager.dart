import 'package:flutter/material.dart';

import '../presentation/Palette.dart';

ThemeData get lightTheme => ThemeData(
    primaryColor: Palette.primaryColor,
    scaffoldBackgroundColor: Colors.grey[200],
    useMaterial3: false,
    appBarTheme: appBarTheme(),
    bottomNavigationBarTheme: navBarTheme(),
    textTheme: textTheme,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Palette.primaryColor));

ThemeData get darkTheme => ThemeData(
      primaryColor: Palette.primaryColor,
      scaffoldBackgroundColor: Palette.darkPrimaryColor,
      useMaterial3: false,
      appBarTheme: appBarTheme(
        textColor: Colors.white,
        backgroundColor: Palette.darkPrimaryColor,
        iconColor: Colors.white,
      ),
      bottomNavigationBarTheme: navBarTheme(
          backgroundColor: Palette.darkPrimaryColor,
          unselectedItemColor: Colors.grey),
      textTheme: textTheme,
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Palette.primaryColor,
      ),
    );

BottomNavigationBarThemeData navBarTheme(
    {Color? unselectedItemColor, Color? backgroundColor}) {
  return BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Palette.primaryColor,
      unselectedItemColor: unselectedItemColor ?? Colors.black,
      backgroundColor: backgroundColor ?? Colors.white);
}

AppBarTheme appBarTheme(
        {Color? textColor, Color? backgroundColor, Color? iconColor}) =>
    AppBarTheme(
      titleSpacing: 20,
      titleTextStyle: TextStyle(
        color: textColor ?? Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      backgroundColor: backgroundColor ?? Colors.white,
      elevation: 0,
      iconTheme: IconThemeData(color: iconColor ?? Colors.black, size: 23),
    );

TextTheme get textTheme => const TextTheme(
    bodyMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
    bodySmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
    labelMedium: TextStyle(fontSize: 23, fontWeight: FontWeight.w700),
    labelSmall: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
    headlineMedium: TextStyle(
        color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25));
