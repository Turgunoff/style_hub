import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final lightTheme = ThemeData(
  useMaterial3: true, // Material 3 dizaynidan foydalanish
  fontFamily: GoogleFonts.manrope().fontFamily,
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
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xFF3A3F92), // Asosiy rang
    foregroundColor: Colors.white, // Matn rangi
    iconTheme: IconThemeData(color: Colors.white), // Ikonlar oq rangda
    titleTextStyle: GoogleFonts.manrope(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
  ),

  // Matnlar uchun ranglar
  textTheme: TextTheme(
    bodyLarge: GoogleFonts.manrope(
      color: Colors.black,
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
    bodyMedium: GoogleFonts.manrope(
      color: Colors.black,
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
    displayLarge: GoogleFonts.manrope(
      color: Colors.black,
      fontSize: 32,
      fontWeight: FontWeight.bold,
    ),
    displayMedium: GoogleFonts.manrope(
      color: Colors.black,
      fontSize: 28,
      fontWeight: FontWeight.bold,
    ),
    displaySmall: GoogleFonts.manrope(
      color: Colors.black,
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ),
    headlineLarge: GoogleFonts.manrope(
      color: Colors.black,
      fontSize: 28,
      fontWeight: FontWeight.w700,
    ),
    headlineMedium: GoogleFonts.manrope(
      color: Colors.black,
      fontSize: 22,
      fontWeight: FontWeight.w600,
    ),
    headlineSmall: GoogleFonts.manrope(
      color: Colors.black,
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
    titleLarge: GoogleFonts.manrope(
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
    titleMedium: GoogleFonts.manrope(
      color: Color(0xFF1A237E),
      fontSize: 16,
      fontWeight: FontWeight.w500,
    ),
    titleSmall: GoogleFonts.manrope(
      color: Colors.black,
      fontSize: 14,
      fontWeight: FontWeight.w500,
    ),
    labelLarge: GoogleFonts.manrope(
      color: Colors.black,
      fontSize: 14,
      fontWeight: FontWeight.w500,
    ),
    labelSmall: GoogleFonts.manrope(
      color: Colors.black,
      fontSize: 12,
      fontWeight: FontWeight.w500,
    ),
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
      textStyle: GoogleFonts.manrope(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    ),
  ),

  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16), // TextField uchun radius
    ),
    labelStyle: GoogleFonts.manrope(
      color: Colors.grey[700],
      fontSize: 16,
    ),
    hintStyle: GoogleFonts.manrope(
      color: Colors.grey[400],
      fontSize: 16,
    ),
  ),

  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: Color(0xFFFF6B6B), // Ikkilamchi tugma rangi (Soft Coral)
      textStyle: GoogleFonts.manrope(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    ),
  ),

  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: Color(0xFF3A3F92), // Primary rangda ramka va matn
      side: BorderSide(color: Color(0xFF3A3F92)), // Tugma atrofi chizig'i
      textStyle: GoogleFonts.manrope(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
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
