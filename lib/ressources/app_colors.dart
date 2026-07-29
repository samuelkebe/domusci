import 'package:flutter/material.dart';

/// Palette officielle Domus CI — à utiliser exclusivement dans toute l'app.
class AppColors {
  AppColors._();

  // Couleur principale — Bleu Signature
  static const Color primary = Color(0xFF2171B5);
  static const Color primaryDark = Color(0xFF175A91);

  // Couleur secondaire — Bleu Clair
  static const Color secondary = Color(0xFF6BAED6);

  // Couleur tertiaire — Bleu Pastel
  static const Color tertiary = Color(0xFFBDD7E7);

  // Fond principal — Blanc Glacé
  static const Color background = Color(0xFFEFF3FF);
  static const Color surface = Color(0xFFFFFFFF);

  // Texte
  static const Color textPrimary = Color(0xFF1A1A1A);
  static const Color textSecondary = Color(0xFF6B7280);

  // États
  static const Color success = Color(0xFF2BB673);
  static const Color error = Color(0xFFE53935);
  static const Color warning = Color(0xFFF4B740);
  static const Color favorite = Color(0xFFFF5A5F);

  // Structure
  static const Color border = Color(0xFFE4ECF7);

  // Shadow — rgba(33,113,181,0.08)
  static const Color shadow = Color(0x142171B5);
  static const Color shadowStrong = Color(0x292171B5);

  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primary, Color(0xFF3D8FCE)],
  );

  static const LinearGradient splashGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF2171B5), Color(0xFF1A5C93), Color(0xFF123F68)],
  );
}
