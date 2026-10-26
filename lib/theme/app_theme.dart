import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  static const String fontFamily = 'Poppins';

  static const double buttonRadius = 9999; // Fully-rounded pill
  static const double cardRadius = 8; // 8px radius for cards
  static const double inputRadius = 4; // 4px radius for inputs
  static const double buttonHeight = 48; // 48px height

  static ThemeData get lightTheme => _buildTheme(
        ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          brightness: Brightness.light,
        ).copyWith(
          primary: AppColors.primary,
          onPrimary: AppColors.canvasLight,
          secondary: AppColors.primaryPressed,
          onSecondary: AppColors.canvasLight,
          error: AppColors.warning,
          onError: AppColors.canvasLight,
          surface: AppColors.canvasLight,
          onSurface: AppColors.ink,
          onSurfaceVariant: AppColors.muteLight,
          surfaceContainerLow: AppColors.surfaceCard,
          surfaceContainerHighest: AppColors.surfaceSoft,
          outline: AppColors.ashLight,
        ),
      );

  static ThemeData get darkTheme => _buildTheme(
        ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          brightness: Brightness.dark,
        ).copyWith(
          primary: AppColors.primary,
          onPrimary: AppColors.canvasLight,
          secondary: AppColors.primaryPressed,
          onSecondary: AppColors.canvasLight,
          error: AppColors.warning,
          onError: AppColors.canvasLight,
          surface: AppColors.canvasDark,
          onSurface: AppColors.onDark,
          onSurfaceVariant: AppColors.muteDark,
          surfaceContainerLow: AppColors.surfaceDarkCard,
          surfaceContainerHighest: AppColors.surfaceDarkElevated,
          outline: AppColors.hairlineDark,
        ),
      );

  static const TextTheme _textTheme = TextTheme(
    displayLarge: TextStyle(
      fontSize: 54,
      fontWeight: FontWeight.w300, // Signature Light weight
      height: 1.25,
      letterSpacing: -0.1,
      color: AppColors.ink,
    ),
    displaySmall: TextStyle(
      fontSize: 44,
      fontWeight: FontWeight.w300,
      height: 1.25,
      letterSpacing: 0.1,
      color: AppColors.ink,
    ),
    headlineMedium: TextStyle(
      fontSize: 35,
      fontWeight: FontWeight.w300,
      height: 1.25,
      color: AppColors.ink,
    ),
    headlineSmall: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w300,
      height: 1.25,
      letterSpacing: 0.1,
      color: AppColors.ink,
    ),
    titleLarge: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w300,
      height: 1.25,
      letterSpacing: 0.1,
    ),
    titleMedium: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      height: 1.0,
    ),
    bodyLarge: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w400,
      height: 1.5,
      letterSpacing: 0.1,
    ),
    bodyMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      height: 1.5,
    ),
    labelLarge: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w700,
      height: 1.25,
      letterSpacing: 0.45,
    ),
    bodySmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      height: 1.5,
    ),
  );

  static ThemeData _buildTheme(ColorScheme scheme) {
    final pillShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(buttonRadius),
    );

    OutlineInputBorder inputBorder(Color color, {double width = 1}) {
      return OutlineInputBorder(
        borderRadius: BorderRadius.circular(inputRadius),
        borderSide: BorderSide(color: color, width: width),
      );
    }

    return ThemeData(
      colorScheme: scheme,
      fontFamily: fontFamily,
      textTheme: _textTheme,
      scaffoldBackgroundColor: scheme.surface,
      appBarTheme: AppBarThemeData(
        backgroundColor: scheme.surface,
        foregroundColor: scheme.onSurface,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontFamily: fontFamily,
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: scheme.onSurface,
        ),
      ),
      cardTheme: CardThemeData(
        color: scheme.surfaceContainerLow,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(cardRadius),
          side: BorderSide(color: scheme.outline),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.canvasLight,
          minimumSize: const Size(64, buttonHeight),
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
          shape: pillShape,
          textStyle: const TextStyle(
            fontFamily: fontFamily,
            fontSize: 18,
            fontWeight: FontWeight.w700,
            height: 1.25,
            letterSpacing: 0.45,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: scheme.onSurface,
          minimumSize: const Size(64, buttonHeight),
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
          side: BorderSide(color: scheme.outline, width: 1),
          shape: pillShape,
          textStyle: const TextStyle(
            fontFamily: fontFamily,
            fontSize: 18,
            fontWeight: FontWeight.w700,
            height: 1.25,
            letterSpacing: 0.45,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationThemeData(
        filled: true,
        fillColor: scheme.surfaceContainerHighest,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        border: inputBorder(scheme.outline),
        enabledBorder: inputBorder(scheme.outline),
        focusedBorder: inputBorder(scheme.primary, width: 2),
        errorBorder: inputBorder(scheme.error),
        focusedErrorBorder: inputBorder(scheme.error, width: 2),
      ),
    );
  }
}