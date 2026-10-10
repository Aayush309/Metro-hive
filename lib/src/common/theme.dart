/// Material 3 high-contrast industrial theme for Tunnel Tech.
/// Modern dark slate aesthetic tailored for low-light metro maintenance environments.
library;

import 'package:flutter/material.dart';

ThemeData tunnelTechTheme() {
  const primaryCyan = Color(0xFF00B4D8);
  const secondaryBlue = Color(0xFF0077B6);
  const darkBackground = Color(0xFF0B132B);
  const surfaceCard = Color(0xFF1C2541);
  const surfaceCardBorder = Color(0xFF3A506B);

  final colorScheme = ColorScheme.dark(
    primary: primaryCyan,
    onPrimary: Colors.black,
    primaryContainer: secondaryBlue,
    onPrimaryContainer: Colors.white,
    secondary: const Color(0xFF64DFDF),
    onSecondary: Colors.black,
    surface: darkBackground,
    onSurface: const Color(0xFFF8FAFC),
    surfaceContainerHighest: surfaceCard,
    onSurfaceVariant: const Color(0xFF94A3B8),
    error: const Color(0xFFEF4444),
    onError: Colors.white,
    outline: surfaceCardBorder,
  );

  return ThemeData(
    useMaterial3: true,
    colorScheme: colorScheme,
    scaffoldBackgroundColor: darkBackground,
    fontFamily: 'NotoSansGujarati',

    appBarTheme: const AppBarTheme(
      backgroundColor: darkBackground,
      foregroundColor: Color(0xFFF8FAFC),
      elevation: 0,
      scrolledUnderElevation: 2,
      centerTitle: false,
      titleTextStyle: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.3,
        color: Color(0xFFF8FAFC),
      ),
    ),

    cardTheme: CardThemeData(
      elevation: 4,
      shadowColor: Colors.black.withValues(alpha: 0.4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: surfaceCardBorder, width: 1),
      ),
      color: surfaceCard,
    ),

    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        minimumSize: const Size(double.infinity, 54),
        backgroundColor: primaryCyan,
        foregroundColor: Colors.black,
        elevation: 2,
        shadowColor: primaryCyan.withValues(alpha: 0.3),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(double.infinity, 54),
        foregroundColor: primaryCyan,
        side: const BorderSide(color: primaryCyan, width: 1.5),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    ),

    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryCyan,
      foregroundColor: Colors.black,
      elevation: 6,
      extendedTextStyle: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.4,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),

    listTileTheme: const ListTileThemeData(
      minVerticalPadding: 12,
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      iconColor: primaryCyan,
    ),

    checkboxTheme: CheckboxThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      side: const BorderSide(color: primaryCyan, width: 2),
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return primaryCyan;
        }
        return Colors.transparent;
      }),
      checkColor: WidgetStateProperty.all(Colors.black),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: surfaceCard,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: surfaceCardBorder, width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: surfaceCardBorder, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: primaryCyan, width: 2),
      ),
      hintStyle: const TextStyle(color: Color(0xFF64748B), fontSize: 15),
      prefixIconColor: const Color(0xFF94A3B8),
      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
    ),

    chipTheme: const ChipThemeData(
      backgroundColor: surfaceCard,
      elevation: 1,
      labelStyle: TextStyle(
        color: Color(0xFFF8FAFC),
        fontSize: 13,
        fontWeight: FontWeight.w600,
      ),
      shape: StadiumBorder(
        side: BorderSide(color: surfaceCardBorder, width: 1),
      ),
    ),
  );
}
