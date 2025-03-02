import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: GoogleFonts.manrope().fontFamily,
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
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFFF36C00),
      foregroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: GoogleFonts.manrope(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),
    textTheme: TextTheme(
      bodyLarge: GoogleFonts.manrope(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      bodyMedium: GoogleFonts.manrope(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      displayLarge: GoogleFonts.manrope(
        color: Colors.white,
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
      displayMedium: GoogleFonts.manrope(
        color: Colors.white,
        fontSize: 28,
        fontWeight: FontWeight.bold,
      ),
      displaySmall: GoogleFonts.manrope(
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      headlineLarge: GoogleFonts.manrope(
        color: Colors.white,
        fontSize: 28,
        fontWeight: FontWeight.w700,
      ),
      headlineMedium: GoogleFonts.manrope(
        color: Colors.white,
        fontSize: 22,
        fontWeight: FontWeight.w600,
      ),
      headlineSmall: GoogleFonts.manrope(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
      titleLarge: GoogleFonts.manrope(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      titleMedium: GoogleFonts.manrope(
        color: Color(0xFFE0E0E0),
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      titleSmall: GoogleFonts.manrope(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      labelLarge: GoogleFonts.manrope(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      labelSmall: GoogleFonts.manrope(
        color: Colors.white,
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF121212),
      selectedItemColor: Color(0xFFF36C00),
      unselectedItemColor: Colors.grey,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFFF36C00),
        foregroundColor: Colors.white,
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
        borderRadius: BorderRadius.circular(16),
      ),
      labelStyle: GoogleFonts.manrope(
        color: Colors.grey[400],
        fontSize: 16,
      ),
      hintStyle: GoogleFonts.manrope(
        color: Colors.grey[600],
        fontSize: 16,
      ),
    ),
    cardTheme: CardTheme(
      color: Color(0xFF1E1E1E),
      shadowColor: Colors.black54,
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ));
