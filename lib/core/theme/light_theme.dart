import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  useMaterial3: true, // Use Material 3 design
  colorScheme: const ColorScheme.light(
    primary: Color(0xFFF16D00), // Asosiy rang
    background: Color(0xFFFFFFFF), // Orqa fon rangi
    onBackground: Colors.black, // Asosiy text rangi (qora)
    secondary: Color(0xFFFDECD2), // Ikkilamchi text rangi
    onSecondary: Colors
        .white, // Ikkilamchi elementlar ustidagi text (oq, masalan, button)
    surface: Colors.white, // Card, Dialog, etc. surfaces
    onSurface: Colors.black, // Text on surfaces
    error: Colors.red, // Error color
  ),
  // AppBar uchun alohida sozlamalar (agar kerak bo'lsa)
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFFFFFFFF), // primary rang bilan bir xil
    foregroundColor: Colors.black, // qora rang
    iconTheme: IconThemeData(color: Colors.black), // qora rang
  ),
  // Boshqa sozlamalar (masalan, textTheme, buttonTheme, etc.)
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.black), // bodyText1 is deprecated
    bodyMedium: TextStyle(color: Colors.black), // bodyText2 is deprecated
    displayLarge: TextStyle(color: Colors.black), // headline1 is deprecated
    displayMedium: TextStyle(color: Colors.black), // headline2 is deprecated
    displaySmall: TextStyle(color: Colors.black), // headline3 is deprecated
    headlineMedium: TextStyle(color: Colors.black), // headline4 is deprecated
    headlineSmall: TextStyle(color: Colors.black), // headline5 is deprecated
    titleLarge: TextStyle(color: Colors.black), // headline6 is deprecated
    titleMedium: TextStyle(color: Color(0xFF383838)), // Ikkilamchi text rangi
    titleSmall: TextStyle(color: Colors.black),
    labelLarge: TextStyle(color: Colors.black), // button is deprecated
    labelSmall: TextStyle(color: Colors.black),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    selectedItemColor: Color(0xFFF16B00),
    unselectedItemColor: Colors.grey,
  ),
);
