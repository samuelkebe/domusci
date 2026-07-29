import 'package:flutter/material.dart';
import '../../../ressources/app_colors.dart';
import '../../../ressources/app_spacing.dart';
import '../../../ressources/app_text_styles.dart';

/// Bottom sheet standardisé — coins arrondis 24px, poignée, fond blanc glacé.
Future<T?> showDomusBottomSheet<T>({
  required BuildContext context,
  required String title,
  required Widget child,
  bool scrollable = false,
}) {
  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.85),
          decoration: const BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.vertical(top: Radius.circular(AppSpacing.radiusCard)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 12),
              Container(width: 40, height: 5, decoration: BoxDecoration(color: AppColors.border, borderRadius: BorderRadius.circular(10))),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(title, style: AppTextStyles.h3),
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                        child: const Icon(Icons.close_rounded, size: 16, color: AppColors.textSecondary),
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(child: scrollable ? SingleChildScrollView(child: child) : child),
              const SizedBox(height: 24),
            ],
          ),
        ),
      );
    },
  );
}
