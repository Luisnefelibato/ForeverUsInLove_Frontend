import 'package:flutter/material.dart';

/// Onboarding theme configuration
/// Customize colors here easily
class OnboardingTheme {
  // Background colors
  static const Color backgroundColor = Color(0xFFF5F5F5); // Light gray background
  static const Color skipButtonColor = Colors.black;
  
  // Text colors
  static const Color titleColor = Colors.black;
  static const Color descriptionColor = Colors.black54;
  
  // Dot indicator colors
  static const Color activeDotColor = Colors.black;
  static const Color inactiveDotColor = Color(0xFFE0E0E0);
  
  // Button colors (for permissions screen)
  static const Color primaryButtonColor = Colors.black;
  static const Color primaryButtonTextColor = Colors.white;
  static const Color secondaryButtonColor = Colors.transparent;
  static const Color secondaryButtonTextColor = Colors.black;
  
  // Icon placeholder color
  static const Color iconPlaceholderColor = Color(0xFFE0E0E0);
  static const Color iconBorderColor = Colors.black;
  
  // Switch colors
  static const Color switchActiveColor = Colors.black;
  static const Color switchInactiveColor = Color(0xFFE0E0E0);
  
  // Typography
  static const String fontFamily = 'Delight'; // Set to Delight if you have the font
  static const double titleFontSize = 32.0;
  static const FontWeight titleFontWeight = FontWeight.bold;
  static const double bodyFontSize = 14.0;
  static const double skipFontSize = 14.0;
  
  // Spacing
  static const double topPadding = 48.0;
  static const double horizontalPadding = 24.0;
  static const double bottomPadding = 32.0;
}
