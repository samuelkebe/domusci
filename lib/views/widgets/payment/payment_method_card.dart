import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/lucide.dart';
import '../../../ressources/app_colors.dart';
import '../../../ressources/app_text_styles.dart';

/// Carte de méthode de paiement — Orange Money, Wave, MTN, Moov, carte bancaire.
class PaymentMethodCard extends StatelessWidget {
  final String name;
  final String subtitle;
  final Color brandColor;
  final String? icon;
  final VoidCallback? onTap;

  const PaymentMethodCard({
    super.key,
    required this.name,
    required this.subtitle,
    required this.brandColor,
    this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(color: brandColor.withOpacity(0.13), borderRadius: BorderRadius.circular(12)),
              child: Iconify(icon!, color: brandColor, size: 18),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: AppTextStyles.bodyMd.copyWith(fontWeight: FontWeight.w700)),
                  Text(subtitle, style: AppTextStyles.caption),
                ],
              ),
            ),
            const Iconify(Lucide.chevron_right, size: 16, color: AppColors.textSecondary),
          ],
        ),
      ),
    );
  }
}
