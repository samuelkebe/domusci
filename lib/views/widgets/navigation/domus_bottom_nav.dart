import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/lucide.dart';
import '../../../ressources/app_colors.dart';

/// Bottom Navigation à 5 onglets — Accueil, Explorer, Publier (FAB central), Favoris, Profil.
class DomusBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final VoidCallback onPublishTap;

  const DomusBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.onPublishTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom + 10, top: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.96),
        border: const Border(top: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        children: [
          _NavItem(icon: Lucide.home, label: 'Accueil', active: currentIndex == 0, onTap: () => onTap(0)),
          _NavItem(icon: Lucide.search, label: 'Explorer', active: currentIndex == 1, onTap: () => onTap(1)),
          _PublishItem(onTap: onPublishTap),
          _NavItem(icon: Lucide.heart, label: 'Favoris', active: currentIndex == 2, onTap: () => onTap(2)),
          _NavItem(icon: Lucide.user, label: 'Profil', active: currentIndex == 3, onTap: () => onTap(3)),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final String icon;
  final String label;
  final bool active;
  final VoidCallback onTap;
  const _NavItem({required this.icon, required this.label, required this.active, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final color = active ? AppColors.primary : AppColors.textSecondary;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          HapticFeedback.selectionClick();
          onTap();
        },
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Iconify(icon, size: 21, color: color),
            const SizedBox(height: 3),
            Text(label, style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.w600, color: color)),
            if (active) ...[
              const SizedBox(height: 2),
              Container(width: 5, height: 5, decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle)),
            ],
          ],
        ),
      ),
    );
  }
}

class _PublishItem extends StatelessWidget {
  final VoidCallback onTap;
  const _PublishItem({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          HapticFeedback.mediumImpact();
          onTap();
        },
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 46,
              height: 46,
              margin: const EdgeInsets.only(bottom: 2),
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [BoxShadow(color: AppColors.shadowStrong, blurRadius: 16, offset: Offset(0, 8))],
              ),
              child: const Iconify(Lucide.plus, color: Colors.white, size: 24),
            ),
          ],
        ),
      ),
    );
  }
}
