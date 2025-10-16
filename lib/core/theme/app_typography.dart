import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTypography {
  // Font family
  static const String fontFamily = 'SF Pro Display';
  static const String fontFamilyMono = 'SF Mono';

  // Line heights
  static const double lineHeightTight = 1.2;
  static const double lineHeightNormal = 1.4;
  static const double lineHeightRelaxed = 1.6;

  // Letter spacing
  static const double letterSpacingTight = -0.5;
  static const double letterSpacingNormal = 0.0;
  static const double letterSpacingWide = 0.5;

  // Display styles - For hero sections and large headings
  static const TextStyle display1 = TextStyle(
    fontSize: 48,
    fontWeight: FontWeight.w700,
    height: lineHeightTight,
    letterSpacing: letterSpacingTight,
    color: AppColors.grey900,
  );

  static const TextStyle display2 = TextStyle(
    fontSize: 40,
    fontWeight: FontWeight.w600,
    height: lineHeightTight,
    letterSpacing: letterSpacingTight,
    color: AppColors.grey900,
  );

  static const TextStyle display3 = TextStyle(
    fontSize: 36,
    fontWeight: FontWeight.w600,
    height: lineHeightTight,
    letterSpacing: letterSpacingTight,
    color: AppColors.grey900,
  );

  // Heading styles
  static const TextStyle h1 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    height: lineHeightTight,
    letterSpacing: letterSpacingTight,
    color: AppColors.grey900,
  );

  static const TextStyle h2 = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    height: lineHeightTight,
    letterSpacing: letterSpacingNormal,
    color: AppColors.grey900,
  );

  static const TextStyle h3 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    height: lineHeightNormal,
    letterSpacing: letterSpacingNormal,
    color: AppColors.grey900,
  );

  static const TextStyle h4 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: lineHeightNormal,
    letterSpacing: letterSpacingNormal,
    color: AppColors.grey900,
  );

  static const TextStyle h5 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    height: lineHeightNormal,
    letterSpacing: letterSpacingNormal,
    color: AppColors.grey900,
  );

  static const TextStyle h6 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: lineHeightNormal,
    letterSpacing: letterSpacingNormal,
    color: AppColors.grey900,
  );

  // Body styles
  static const TextStyle bodyLarge = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    height: lineHeightRelaxed,
    letterSpacing: letterSpacingNormal,
    color: AppColors.grey700,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: lineHeightRelaxed,
    letterSpacing: letterSpacingNormal,
    color: AppColors.grey700,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: lineHeightNormal,
    letterSpacing: letterSpacingNormal,
    color: AppColors.grey600,
  );

  // Label styles
  static const TextStyle labelLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: lineHeightNormal,
    letterSpacing: letterSpacingWide,
    color: AppColors.grey900,
  );

  static const TextStyle labelMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: lineHeightNormal,
    letterSpacing: letterSpacingWide,
    color: AppColors.grey700,
  );

  static const TextStyle labelSmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: lineHeightNormal,
    letterSpacing: letterSpacingWide,
    color: AppColors.grey600,
  );

  // Button styles
  static const TextStyle buttonLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: lineHeightTight,
    letterSpacing: letterSpacingWide,
  );

  static const TextStyle buttonMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: lineHeightTight,
    letterSpacing: letterSpacingWide,
  );

  static const TextStyle buttonSmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    height: lineHeightTight,
    letterSpacing: letterSpacingWide,
  );

  // Caption and overline styles
  static const TextStyle caption = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: lineHeightNormal,
    letterSpacing: letterSpacingNormal,
    color: AppColors.grey500,
  );

  static const TextStyle overline = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w600,
    height: lineHeightNormal,
    letterSpacing: 1.0,
    color: AppColors.grey500,
  );

  // Special styles
  static const TextStyle link = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: lineHeightNormal,
    letterSpacing: letterSpacingNormal,
    color: AppColors.primary,
    decoration: TextDecoration.underline,
  );

  static const TextStyle code = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: lineHeightNormal,
    letterSpacing: letterSpacingNormal,
    fontFamily: fontFamilyMono,
    color: AppColors.grey800,
  );

  // Status styles
  static const TextStyle success = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: lineHeightNormal,
    color: AppColors.success,
  );

  static const TextStyle warning = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: lineHeightNormal,
    color: AppColors.warning,
  );

  static const TextStyle error = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: lineHeightNormal,
    color: AppColors.error,
  );

  static const TextStyle info = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: lineHeightNormal,
    color: AppColors.info,
  );

  // Navigation styles
  static const TextStyle navLabel = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: lineHeightNormal,
    letterSpacing: letterSpacingNormal,
  );

  static const TextStyle tabLabel = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: lineHeightNormal,
    letterSpacing: letterSpacingWide,
  );

  // Role-specific styles
  static const TextStyle roleAdmin = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    height: lineHeightNormal,
    letterSpacing: letterSpacingWide,
    color: AppColors.adminPrimary,
  );

  static const TextStyle roleTeacher = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    height: lineHeightNormal,
    letterSpacing: letterSpacingWide,
    color: AppColors.teacherPrimary,
  );

  static const TextStyle roleStudent = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    height: lineHeightNormal,
    letterSpacing: letterSpacingWide,
    color: AppColors.studentPrimary,
  );
}