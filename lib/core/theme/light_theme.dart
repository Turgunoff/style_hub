import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  useMaterial3: true, // Material 3 dizaynidan foydalanish
  colorScheme: const ColorScheme.light(
    primary: Color(0xFF3A3F92), // Asosiy rang (Royal Blue)
    background: Color(0xFFFFFFFF), // Orqa fon rangi (oq)
    onBackground: Colors.black, // Asosiy matn rangi (qora)
    secondary: Color(0xFFFF6B6B), // Ikkilamchi rang (Soft Coral)
    tertiary: Color(0xFFE3E6FA), // ✅ Icon background uchun Light Blue
    onSecondary: Colors.white, // Ikkilamchi elementlar ustidagi matn (oq)
    surface: Colors.white, // Kartalar, dialoglar uchun fon rangi
    onSurface:
        Colors.black, // Kartalar va boshqa yuzalar ustidagi matn rangi (qora)
    error: Colors.red, // Xatolik rangi
  ),

  scaffoldBackgroundColor: Color(0xFFF8F9FA), // Ilovaning umumiy backgroundi

  // AppBar uchun sozlamalar
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF3A3F92), // Asosiy rang
    foregroundColor: Colors.white, // Matn rangi
    iconTheme: IconThemeData(color: Colors.white), // Ikonlar oq rangda
  ),

  // Matnlar uchun ranglar
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.black),
    bodyMedium: TextStyle(color: Colors.black),
    displayLarge: TextStyle(color: Colors.black),
    displayMedium: TextStyle(color: Colors.black),
    displaySmall: TextStyle(color: Colors.black),
    headlineMedium: TextStyle(color: Colors.black),
    headlineSmall: TextStyle(color: Colors.black),
    titleLarge: TextStyle(color: Colors.black),
    titleMedium: TextStyle(
        color: Color(0xFF1A237E)), // Dark Blue - yaxshi kontrast uchun
    titleSmall: TextStyle(color: Colors.black),
    labelLarge: TextStyle(color: Colors.black),
    labelSmall: TextStyle(color: Colors.black),
  ),

  // Bottom Navigation Bar sozlamalari
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    selectedItemColor: Color(0xFF3A3F92), // Royal Blue - primary rangga mos
    unselectedItemColor: Colors.grey,
  ),

  // ✅ Buttonlar uchun ranglar
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Color(0xFF3A3F92), // Primary rang
      foregroundColor: Colors.white, // Oq matn
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
    ),
  ),

  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16), // TextField uchun radius
    ),
  ),

  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: Color(0xFFFF6B6B), // Ikkilamchi tugma rangi (Soft Coral)
    ),
  ),

  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: Color(0xFF3A3F92), // Primary rangda ramka va matn
      side: BorderSide(color: Color(0xFF3A3F92)), // Tugma atrofi chizig‘i
    ),
  ),

  // ✅ Card (kartalar) uchun dizayn
  cardTheme: CardTheme(
    color: Colors.white, // Kartalar orqa foni
    shadowColor: Color(0xFFBDBDBD), // Soyalar uchun kulrang
    elevation: 1, // Soyaning balandligi
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16), // Yumshoq burchaklar
    ),
  ),
);
