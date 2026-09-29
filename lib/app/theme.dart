import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Ultra-modern Creative Palette (Dark Navy / Electric Indigo / Cyber Teal / Sunset Coral)
  static const Color primaryDark = Color(0xFF0F172A);
  static const Color primaryNavy = Color(0xFF1E1B4B);
  static const Color accentIndigo = Color(0xFF6366F1);
  static const Color accentBlue = Color(0xFF3B82F6);
  static const Color accentTeal = Color(0xFF0D9488);
  static const Color accentEmerald = Color(0xFF10B981);
  static const Color accentCoral = Color(0xFFF43F5E);
  static const Color accentAmber = Color(0xFFF59E0B);
  static const Color accentPurple = Color(0xFF8B5CF6);

  static const Color bgLight = Color(0xFFF8FAFC);
  static const Color cardBg = Colors.white;
  static const Color textMain = Color(0xFF0F172A);
  static const Color textMuted = Color(0xFF64748B);
  static const Color borderLight = Color(0xFFE2E8F0);

  static ThemeData get lightTheme {
    final baseTextTheme = GoogleFonts.interTextTheme();

    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: bgLight,
      colorScheme: ColorScheme.fromSeed(
        seedColor: accentIndigo,
        primary: primaryDark,
        secondary: accentIndigo,
        tertiary: accentTeal,
        surface: cardBg,
        error: accentCoral,
      ),
      textTheme: baseTextTheme.copyWith(
        displayLarge: GoogleFonts.plusJakartaSans(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: textMain,
          letterSpacing: -0.6,
        ),
        headlineMedium: GoogleFonts.plusJakartaSans(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: textMain,
          letterSpacing: -0.3,
        ),
        titleLarge: GoogleFonts.plusJakartaSans(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: textMain,
        ),
        titleMedium: GoogleFonts.plusJakartaSans(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: textMain,
        ),
        bodyLarge: GoogleFonts.inter(
          fontSize: 15,
          color: textMain,
          height: 1.5,
        ),
        bodyMedium: GoogleFonts.inter(
          fontSize: 13,
          color: textMuted,
          height: 1.4,
        ),
      ),
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: cardBg,
        foregroundColor: textMain,
        centerTitle: false,
        titleTextStyle: GoogleFonts.plusJakartaSans(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: textMain,
        ),
        iconTheme: const IconThemeData(color: textMain),
      ),
      cardTheme: CardThemeData(
        color: cardBg,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: Color(0xFFE2E8F0), width: 1.2),
        ),
        margin: EdgeInsets.zero,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryDark,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: GoogleFonts.plusJakartaSans(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryDark,
          side: const BorderSide(color: borderLight, width: 1.5),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: GoogleFonts.plusJakartaSans(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: bgLight,
        side: const BorderSide(color: borderLight),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        labelStyle: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: textMain,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: borderLight),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: borderLight),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: accentIndigo, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: accentCoral),
        ),
        labelStyle: const TextStyle(color: textMuted),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: accentIndigo,
        unselectedItemColor: textMuted,
        type: BottomNavigationBarType.fixed,
        elevation: 10,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
      ),
    );
  }
}
