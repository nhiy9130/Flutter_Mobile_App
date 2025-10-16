import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color primary = Color(0xFF6366F1); // Indigo-500
  static const Color primaryLight = Color(0xFF818CF8); // Indigo-400
  static const Color primaryDark = Color(0xFF4F46E5); // Indigo-600
  static const Color primaryContainer = Color(0xFFE0E7FF); // Indigo-100

  // Secondary Colors
  static const Color secondary = Color(0xFF8B5CF6); // Purple-500
  static const Color secondaryLight = Color(0xFFA78BFA); // Purple-400
  static const Color secondaryDark = Color(0xFF7C3AED); // Purple-600
  static const Color secondaryContainer = Color(0xFFF3E8FF); // Purple-100

  // Accent Colors
  static const Color accent = Color(0xFF06B6D4); // Cyan-500
  static const Color accentLight = Color(0xFF22D3EE); // Cyan-400
  static const Color accentDark = Color(0xFF0891B2); // Cyan-600

  // Success Colors
  static const Color success = Color(0xFF10B981); // Emerald-500
  static const Color successLight = Color(0xFF34D399); // Emerald-400
  static const Color successDark = Color(0xFF059669); // Emerald-600
  static const Color successContainer = Color(0xFFD1FAE5); // Emerald-100

  // Warning Colors
  static const Color warning = Color(0xFFF59E0B); // Amber-500
  static const Color warningLight = Color(0xFFFBBF24); // Amber-400
  static const Color warningDark = Color(0xFFD97706); // Amber-600
  static const Color warningContainer = Color(0xFFFEF3C7); // Amber-100

  // Error Colors
  static const Color error = Color(0xFFEF4444); // Red-500
  static const Color errorLight = Color(0xFFF87171); // Red-400
  static const Color errorDark = Color(0xFFDC2626); // Red-600
  static const Color errorContainer = Color(0xFFFEE2E2); // Red-100

  // Info Colors
  static const Color info = Color(0xFF3B82F6); // Blue-500
  static const Color infoLight = Color(0xFF60A5FA); // Blue-400
  static const Color infoDark = Color(0xFF2563EB); // Blue-600
  static const Color infoContainer = Color(0xFFDBEAFE); // Blue-100

  // Neutral Colors - Light Theme
  static const Color white = Color(0xFFFFFFFF);
  static const Color grey50 = Color(0xFFF8FAFC); // Slate-50
  static const Color grey100 = Color(0xFFF1F5F9); // Slate-100
  static const Color grey200 = Color(0xFFE2E8F0); // Slate-200
  static const Color grey300 = Color(0xFFCBD5E1); // Slate-300
  static const Color grey400 = Color(0xFF94A3B8); // Slate-400
  static const Color grey500 = Color(0xFF64748B); // Slate-500
  static const Color grey600 = Color(0xFF475569); // Slate-600
  static const Color grey700 = Color(0xFF334155); // Slate-700
  static const Color grey800 = Color(0xFF1E293B); // Slate-800
  static const Color grey900 = Color(0xFF0F172A); // Slate-900

  // Role-based Colors
  static const Color adminPrimary = Color(0xFFDC2626); // Red-600
  static const Color teacherPrimary = Color(0xFF059669); // Emerald-600
  static const Color studentPrimary = Color(0xFF2563EB); // Blue-600

  // Gradient Colors
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, primaryLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient secondaryGradient = LinearGradient(
    colors: [secondary, secondaryLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient accentGradient = LinearGradient(
    colors: [accent, accentLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Role-based Gradients
  static const LinearGradient adminGradient = LinearGradient(
    colors: [adminPrimary, Color(0xFFF87171)], // Red gradient
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient teacherGradient = LinearGradient(
    colors: [teacherPrimary, successLight], // Green gradient
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient studentGradient = LinearGradient(
    colors: [studentPrimary, infoLight], // Blue gradient
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Shadow Colors
  static Color shadow = Colors.black.withOpacity(0.1);
  static Color shadowLight = Colors.black.withOpacity(0.05);
  static Color shadowMedium = Colors.black.withOpacity(0.15);
  static Color shadowDark = Colors.black.withOpacity(0.25);

  // Shimmer Colors
  static const Color shimmerBase = grey200;
  static const Color shimmerHighlight = white;

  // Dark Theme Colors
  static const Color darkBackground = grey900;
  static const Color darkSurface = grey800;
  static const Color darkCard = grey700;
  static const Color darkBorder = grey600;
}