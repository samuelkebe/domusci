import 'package:flutter/material.dart';
import '../../../models/property.dart';
import '../../../ressources/app_colors.dart';
import '../../../ressources/app_spacing.dart';

class DomusBadge extends StatelessWidget {
  final PropertyBadge badge;
  const DomusBadge({super.key, required this.badge});

  Color get _color {
    switch (badge) {
      case PropertyBadge.nouveau:
        return AppColors.success;
      case PropertyBadge.exclusif:
        return AppColors.primary;
      case PropertyBadge.coupDeCoeur:
        return AppColors.favorite;
      case PropertyBadge.none:
        return Colors.transparent;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (badge == PropertyBadge.none) return const SizedBox.shrink();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(color: _color, borderRadius: BorderRadius.circular(AppSpacing.sm)),
      child: Text(
        badge == PropertyBadge.nouveau
            ? 'Nouveau'
            : badge == PropertyBadge.exclusif
                ? 'Exclusif'
                : 'Coup de cœur',
        style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700),
      ),
    );
  }
}

class StatusPill extends StatelessWidget {
  final String label;
  final Color color;
  const StatusPill({super.key, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(AppSpacing.sm)),
      child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700)),
    );
  }
}
