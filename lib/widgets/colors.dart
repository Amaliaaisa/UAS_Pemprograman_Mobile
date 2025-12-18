import 'package:flutter/material.dart';

class AppColors {
  // Primary Pink Theme
  static const Color primaryPink = Color(0xFFE91E63);
  static const Color lightPink = Color(0xFFFCE4EC);
  static const Color darkPink = Color(0xFFC2185B);
  
  // Secondary Colors
  static const Color peach = Color(0xFFFF9800);
  static const Color blue = Color(0xFF2196F3);
  static const Color lavender = Color(0xFF9C27B0);
  static const Color mint = Color(0xFF4CAF50);
  
  // Neutral Colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color lightGrey = Color(0xFFF5F5F5);
  static const Color mediumGrey = Color(0xFF9E9E9E);
  static const Color darkGrey = Color(0xFF333333);
  
  // Background Colors
  static const Color background = Color(0xFFFEF6F9);
  
  // Gradient
  static const LinearGradient pinkGradient = LinearGradient(
    colors: [Color(0xFFE91E63), Color(0xFFF06292)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}