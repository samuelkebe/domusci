import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/lucide.dart';
import '../../../ressources/app_colors.dart';
import '../../../ressources/app_spacing.dart';
import '../../../ressources/app_text_styles.dart';

/// Barre de recherche intelligente — réutilisée sur Accueil et Recherche.
class DomusSearchBar extends StatelessWidget {
  final String hint;
  final VoidCallback? onTap;
  final VoidCallback? onFilterTap;
  final bool readOnly;
  final TextEditingController? controller;

  const DomusSearchBar({
    super.key,
    this.hint = 'Rechercher un quartier, un bien…',
    this.onTap,
    this.onFilterTap,
    this.readOnly = true,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        border: Border.all(color: AppColors.border),
        boxShadow: const [BoxShadow(color: AppColors.shadow, blurRadius: 18, offset: Offset(0, 8))],
      ),
      child: Row(
        children: [
          const Iconify(Lucide.search, size: 18, color: AppColors.textSecondary),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: controller,
              readOnly: readOnly,
              onTap: onTap,
              style: AppTextStyles.bodyMd,
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: AppTextStyles.bodyMd.copyWith(color: AppColors.textSecondary),
                border: InputBorder.none,
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ),
          if (onFilterTap != null)
            GestureDetector(
              onTap: onFilterTap,
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(10)),
                child: const Iconify(Lucide.sliders_horizontal, size: 15, color: AppColors.primary),
              ),
            ),
        ],
      ),
    );
  }
}
