import 'package:flutter/material.dart';

/// Application color palette following the minimalist design system
class AppColors {
  AppColors._();

  // Background Colors
  static const Color backgroundColor = Color(0xFFFFFFFF);
  static const Color surfaceColor = Color(0xFFF5F5F7);
  static const Color borderColor = Color(0xFFE5E5E7);

  // Text Colors
  static const Color textPrimary = Color(0xFF1A1A1A);
  static const Color textSecondary = Color(0xFF6B6B6B);
  static const Color textDisabled = Color(0xFFB0B0B0);

  // Accent Colors
  static const Color primaryColor = Color(0xFF0066FF);
  static const Color primaryHover = Color(0xFF0052CC);
  static const Color primaryPressed = Color(0xFF003D99);

  // Semantic Colors
  static const Color errorColor = Color(0xFFDC3545);
  static const Color successColor = Color(0xFF28A745);
  static const Color warningColor = Color(0xFFFFC107);
  static const Color infoColor = Color(0xFF17A2B8);

  // Selection Colors
  static const Color selectionColor = primaryColor;
  static const Color selectionHandleColor = Color(0xFFFFFFFF);
  static const Color selectionHandleBorder = primaryColor;

  // Hover Effects
  static const Color hoverColor = Color(0x0A0066FF); // 4% opacity of primary

  // Divider
  static const Color dividerColor = borderColor;

  // Shadow Colors
  static const Color shadowColorSubtle = Color(0x0A000000); // 4% black
  static const Color shadowColorMedium = Color(0x14000000); // 8% black
  static const Color shadowColorLarge = Color(0x1F000000); // 12% black

  // Overlay (for modals, dialogs)
  static const Color overlayColor = Color(0x66000000); // 40% black

  // Drag Ghost
  static const Color dragGhostColor = Color(0x80000000); // 50% black tint

  // Panel Divider (resizable)
  static const Color panelDividerColor = borderColor;
  static const Color panelDividerHoverColor = primaryColor;

  // Card Background
  static const Color cardColor = backgroundColor;

  // Tooltip Background
  static const Color tooltipBackgroundColor = Color(0xE6000000); // 90% black
  static const Color tooltipTextColor = Color(0xFFFFFFFF);

  // Disabled
  static const Color disabledColor = Color(0xFFE0E0E0);
  static const Color disabledTextColor = textDisabled;

  // Focus
  static const Color focusColor = primaryColor;
}