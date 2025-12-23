import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Primary Colors
  static const Color primary = Color(0xFF2563EB); // Blue-600
  static const Color primaryDark = Color(0xFF1D4ED8); // Blue-700
  static const Color primaryLight = Color(0xFF3B82F6); // Blue-500

  // Secondary Colors
  static const Color secondary = Color(0xFF10B981); // Emerald-500
  static const Color secondaryDark = Color(0xFF059669); // Emerald-600

  // Accent Colors
  static const Color accent = Color(0xFFF59E0B); // Amber-500
  static const Color accentLight = Color(0xFFFBBF24); // Amber-400

  // Background Colors
  static const Color background = Color(0xFFF9FAFB); // Gray-50
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF3F4F6); // Gray-100

  // Text Colors
  static const Color textPrimary = Color(0xFF111827); // Gray-900
  static const Color textSecondary = Color(0xFF6B7280); // Gray-500
  static const Color textTertiary = Color(0xFF9CA3AF); // Gray-400

  // Status Colors
  static const Color success = Color(0xFF10B981); // Emerald-500
  static const Color warning = Color(0xFFF59E0B); // Amber-500
  static const Color error = Color(0xFFEF4444); // Red-500
  static const Color info = Color(0xFF3B82F6); // Blue-500

  // Gradient Colors
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, primaryDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient heroGradient = LinearGradient(
    colors: [Color(0x80000000), Color(0x40000000)],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  );

  // Card Shadow
  static List<BoxShadow> cardShadow = [
    BoxShadow(
      color: Colors.black.withOpacity(0.08),
      blurRadius: 16,
      offset: const Offset(0, 4),
    ),
  ];

  static List<BoxShadow> elevatedShadow = [
    BoxShadow(
      color: Colors.black.withOpacity(0.12),
      blurRadius: 24,
      offset: const Offset(0, 8),
    ),
  ];
}
