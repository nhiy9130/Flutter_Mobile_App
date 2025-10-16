import 'package:flutter/material.dart';

class AppSpacing {
  // Base unit (8px) - All spacing should be multiples of this
  static const double unit = 8.0;

  // Micro spacing
  static const double xs2 = unit * 0.25; // 2px
  static const double xs = unit * 0.5; // 4px

  // Small spacing
  static const double sm = unit * 1; // 8px
  static const double smMd = unit * 1.5; // 12px
  static const double md = unit * 2; // 16px

  // Medium spacing
  static const double mdLg = unit * 2.5; // 20px
  static const double lg = unit * 3; // 24px
  static const double lgXl = unit * 3.5; // 28px
  static const double xl = unit * 4; // 32px

  // Large spacing
  static const double xl2 = unit * 5; // 40px
  static const double xl3 = unit * 6; // 48px
  static const double xl4 = unit * 8; // 64px
  static const double xl5 = unit * 10; // 80px
  static const double xl6 = unit * 12; // 96px

  // Screen padding
  static const double screenHorizontal = md; // 16px
  static const double screenVertical = lg; // 24px
  
  // Card padding
  static const double cardPadding = md; // 16px
  static const double cardPaddingLarge = lg; // 24px
  
  // List item spacing
  static const double listItemVertical = sm; // 8px
  static const double listItemHorizontal = md; // 16px
  
  // Button spacing
  static const double buttonHorizontal = lg; // 24px
  static const double buttonVertical = smMd; // 12px
  
  // Form spacing
  static const double formFieldSpacing = md; // 16px
  static const double formSectionSpacing = xl; // 32px
  
  // Section spacing
  static const double sectionSpacing = lg; // 24px
  static const double sectionHeaderSpacing = sm; // 8px
}

class AppRadius {
  // Border radius values
  static const double xs = 4.0;
  static const double sm = 6.0;
  static const double md = 8.0;
  static const double lg = 12.0;
  static const double xl = 16.0;
  static const double xl2 = 20.0;
  static const double xl3 = 24.0;
  static const double full = 999.0;

  // Specific component radius
  static const double button = lg; // 12px
  static const double card = lg; // 12px
  static const double input = lg; // 12px
  static const double dialog = xl; // 16px
  static const double bottomSheet = xl2; // 20px
  static const double avatar = full; // Circular
  static const double chip = xl3; // 24px
}

class AppElevation {
  static const double none = 0;
  static const double sm = 2;
  static const double md = 4;
  static const double lg = 8;
  static const double xl = 12;
  static const double xl2 = 16;
  static const double xl3 = 24;
}

class AppShadows {
  static List<BoxShadow> get sm => [
    BoxShadow(
      color: Colors.black.withOpacity(0.1),
      offset: const Offset(0, 1),
      blurRadius: 2,
      spreadRadius: 0,
    ),
  ];

  static List<BoxShadow> get md => [
    BoxShadow(
      color: Colors.black.withOpacity(0.1),
      offset: const Offset(0, 4),
      blurRadius: 6,
      spreadRadius: -1,
    ),
    BoxShadow(
      color: Colors.black.withOpacity(0.06),
      offset: const Offset(0, 2),
      blurRadius: 4,
      spreadRadius: -1,
    ),
  ];

  static List<BoxShadow> get lg => [
    BoxShadow(
      color: Colors.black.withOpacity(0.1),
      offset: const Offset(0, 10),
      blurRadius: 15,
      spreadRadius: -3,
    ),
    BoxShadow(
      color: Colors.black.withOpacity(0.05),
      offset: const Offset(0, 4),
      blurRadius: 6,
      spreadRadius: -2,
    ),
  ];

  static List<BoxShadow> get xl => [
    BoxShadow(
      color: Colors.black.withOpacity(0.1),
      offset: const Offset(0, 20),
      blurRadius: 25,
      spreadRadius: -5,
    ),
    BoxShadow(
      color: Colors.black.withOpacity(0.04),
      offset: const Offset(0, 10),
      blurRadius: 10,
      spreadRadius: -5,
    ),
  ];
}

class AppSizes {
  // Icon sizes
  static const double iconXs = 12;
  static const double iconSm = 16;
  static const double iconMd = 20;
  static const double iconLg = 24;
  static const double iconXl = 32;
  static const double iconXl2 = 48;
  static const double iconXl3 = 64;

  // Avatar sizes
  static const double avatarSm = 32;
  static const double avatarMd = 40;
  static const double avatarLg = 48;
  static const double avatarXl = 64;
  static const double avatarXl2 = 80;
  static const double avatarXl3 = 96;

  // Button heights
  static const double buttonSm = 36;
  static const double buttonMd = 44;
  static const double buttonLg = 52;

  // Input heights
  static const double inputSm = 36;
  static const double inputMd = 44;
  static const double inputLg = 52;

  // Card dimensions
  static const double cardMinHeight = 120;
  static const double cardMaxWidth = 400;

  // App bar height
  static const double appBarHeight = 56;
  static const double tabBarHeight = 48;

  // Bottom navigation height
  static const double bottomNavHeight = 80;

  // Floating action button
  static const double fabSize = 56;
  static const double fabSizeLarge = 64;
}