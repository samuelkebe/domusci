import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import '../../../ressources/app_colors.dart';
import '../../../ressources/app_spacing.dart';
import '../../../ressources/app_text_styles.dart';

/// Chip de catégorie / filtre — état actif en Bleu Signature.
class DomusChip extends StatelessWidget {
  final String label;
  final String? icon;
  final bool active;
  final VoidCallback? onTap;
  final bool tertiary;

  const DomusChip({
    super.key,
    required this.label,
    this.icon,
    this.active = false,
    this.onTap,
    this.tertiary = false,
  });

  @override
  Widget build(BuildContext context) {
    final bg = active ? AppColors.primary : (tertiary ? AppColors.tertiary : Colors.white);
    final fg = active ? Colors.white : (tertiary ? AppColors.primaryDark : AppColors.textSecondary);
    final border = active ? AppColors.primary : (tertiary ? AppColors.tertiary : AppColors.border);

    return GestureDetector(
      onTap: () {
        HapticFeedback.selectionClick();
        onTap?.call();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 9),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(AppSpacing.radiusPill),
          border: Border.all(color: border),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[Iconify(icon!, size: 14, color: fg), const SizedBox(width: 6)],
            Text(label, style: AppTextStyles.label.copyWith(color: fg, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}

/// Grande tuile de catégorie utilisée sur l'écran d'accueil.
class CategoryTile extends StatelessWidget {
  final String? icon;
  final String label;
  final bool active;
  final VoidCallback? onTap;

  const CategoryTile({super.key,  this.icon, required this.label, this.active = false, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 64,
        child: Column(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: active ? AppColors.primary : Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: active ? AppColors.primary : AppColors.border),
                boxShadow: const [BoxShadow(color: AppColors.shadow, blurRadius: 14, offset: Offset(0, 6))],
              ),
              child: Iconify(icon!, color: active ? Colors.white : AppColors.primary, size: 22),
            ),
            const SizedBox(height: 7),
            Text(
              label,
              textAlign: TextAlign.center,
              style: AppTextStyles.caption.copyWith(color: active ? AppColors.primary : AppColors.textSecondary),
            ),
          ],
        ),
      ),
    );
  }
}
