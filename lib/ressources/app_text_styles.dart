import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// Hiérarchie typographique — Inter (fallback SF Pro Display sur iOS).
class AppTextStyles {
  AppTextStyles._();

  static TextStyle _base(double size, FontWeight weight, {Color? color, double? letterSpacing, double? height}) {
    return GoogleFonts.inter(
      fontSize: size,
      fontWeight: weight,
      color: color ?? AppColors.textPrimary,
      letterSpacing: letterSpacing,
      height: height,
    );
  }

  // Display / Titres
  static TextStyle h1 = _base(28, FontWeight.w800, letterSpacing: -0.4);
  static TextStyle h2 = _base(23, FontWeight.w800, letterSpacing: -0.3);
  static TextStyle h3 = _base(19, FontWeight.w700, letterSpacing: -0.2);
  static TextStyle h4 = _base(17, FontWeight.w700, letterSpacing: -0.1);

  // Corps
  static TextStyle bodyLg = _base(15, FontWeight.w500, height: 1.4);
  static TextStyle bodyMd = _base(13.5, FontWeight.w500, height: 1.45);
  static TextStyle bodySm = _base(12, FontWeight.w500, height: 1.4, color: AppColors.textSecondary);

  // Libellés / caption
  static TextStyle label = _base(12.5, FontWeight.w600, color: AppColors.textSecondary);
  static TextStyle caption = _base(11, FontWeight.w600, color: AppColors.textSecondary);

  // Prix — toujours en Bleu Signature, bien visible
  static TextStyle priceLg = _base(20, FontWeight.w800, color: AppColors.primary, letterSpacing: -0.3);
  static TextStyle priceMd = _base(15.5, FontWeight.w800, color: AppColors.primary, letterSpacing: -0.2);

  // Boutons
  static TextStyle button = _base(15, FontWeight.w700, color: Colors.white);
  static TextStyle buttonGhost = _base(15, FontWeight.w700, color: AppColors.primary);
}
