import 'package:flutter/material.dart';

/// PlayStation Design System Inspired Colors
class AppColors {
  AppColors._();

  // ── Brand & Accent ──
  static const Color primary = Color(0xFF0070D1); // PlayStation Blue
  static const Color primaryPressed = Color(0xFF0064B7); // PlayStation Blue Pressed
  static const Color primaryActive = Color(0xFF004D8D); // PlayStation Blue Active
  static const Color commerce = Color(0xFFD53B00); // Commerce Orange
  static const Color commercePressed = Color(0xAA2F0000);

  // ── Surfaces ──
  static const Color canvasLight = Color(0xFFFFFFFF); // True White
  static const Color canvasDark = Color(0xFF000000); // Pure Black
  static const Color surfaceSoft = Color(0xFFF3F3F3); // Soft surface
  static const Color surfaceCard = Color(0xFFF5F7FA); // Cool-blue tinted card
  static const Color surfaceDarkElevated = Color(0xFF121314);
  static const Color surfaceDarkCard = Color(0xFF181818);

  // ── Text & Neutrals ──
  static const Color ink = Color(0xFF000000); // Primary text on light
  static const Color bodyLight = Color(0x99000000); // 60% black
  static const Color muteLight = Color(0xFF6B6B6B);
  static const Color ashLight = Color(0xFFCCCCCC);
  static const Color hairlineLight = Color(0xFFF3F3F3);

  static const Color onDark = Color(0xFFFFFFFF); // Primary text on dark
  static const Color bodyDark = Color(0xB3FFFFFF); // 70% white
  static const Color muteDark = Color(0x8CE5E5E5); // 55% white
  static const Color hairlineDark = Color(0x33E5E5E5); // 20% white

  // ── Semantic ──
  static const Color warning = Color(0xFFC81B3A); // Warning / Error
  static const Color success = Color(0xFF149E61); // Green success
  static const Color linkLight = Color(0xFF0064B7);
  static const Color linkDark = Color(0xFF53B1FF);

  // ── PS Plus Gold Gradient Colors ──
  static const Color psPlusGoldStart = Color(0xFFFFCE21);
  static const Color psPlusGoldMid = Color(0xFFF5A623);
  static const Color psPlusGoldEnd = Color(0xFFEE8E00);

  // Aliases for compatibility
  static const Color primaryLight = primary;
  static const Color primaryDark = primaryPressed;
  static const Color secondary = primary;
  static const Color onSecondary = canvasLight;
  static const Color error = warning;
  static const Color nearBlack = ink;
  static const Color coolGray = muteLight;
  static const Color borderGray = ashLight;
}