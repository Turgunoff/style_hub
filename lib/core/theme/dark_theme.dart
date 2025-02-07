import 'package:flutter/material.dart';

final darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFFF36C00), // Asosiy rang (dark mode)
      background: Color(0xFF05070C), // Orqa fon rangi (dark mode)
      onBackground: Colors.white, // Asosiy text rangi (oq)
      secondary: Color(0xFFE0E0E0), // Ikkilamchi text rangi (och kulrang)
      onSecondary: Colors.black, // Ikkilamchi elementlar ustidagi text (qora)
      surface: Color(0xFF121212), // Darker surface for cards, dialogs
      onSurface: Colors.white, // Text on surfaces
      error: Colors.redAccent,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFFF36C00),
      foregroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.white),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white),
      displayLarge: TextStyle(color: Colors.white),
      displayMedium: TextStyle(color: Colors.white),
      displaySmall: TextStyle(color: Colors.white),
      headlineMedium: TextStyle(color: Colors.white),
      headlineSmall: TextStyle(color: Colors.white),
      titleLarge: TextStyle(color: Colors.white),
      titleMedium:
          TextStyle(color: Color(0xFFE0E0E0)), // Ikkilamchi text (och kulrang)
      titleSmall: TextStyle(color: Colors.white),
      labelLarge: TextStyle(color: Colors.white),
      labelSmall: TextStyle(color: Colors.white),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF121212),
      selectedItemColor: Color(0xFFF36C00),
      unselectedItemColor: Colors.grey,
    ));
