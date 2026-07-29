import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import '../../../ressources/app_colors.dart';
import '../../../ressources/app_spacing.dart';
import '../../../ressources/app_text_styles.dart';
import '../buttons/primary_button.dart';

/// État vide générique — favoris vides, aucun résultat, aucune annonce…
class EmptyState extends StatelessWidget {
  final String? icon;
  final String title;
  final String description;
  final String? actionLabel;
  final VoidCallback? onAction;

  const EmptyState({
    super.key,
    this.icon,
    required this.title,
    required this.description,
    this.actionLabel,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null)
            Container(
              width: 88,
              height: 88,
              decoration: const BoxDecoration(color: AppColors.background, shape: BoxShape.circle),
              child: Iconify(icon!, size: 34, color: AppColors.primary),
            ),
          const SizedBox(height: AppSpacing.lg),
          Text(title, style: AppTextStyles.h3, textAlign: TextAlign.center),
          const SizedBox(height: AppSpacing.sm),
          Text(description, style: AppTextStyles.bodySm, textAlign: TextAlign.center),
          if (actionLabel != null) ...[
            const SizedBox(height: AppSpacing.lg),
            PrimaryButton( title: '',),
          ],
        ],
      ),
    );
  }
}
