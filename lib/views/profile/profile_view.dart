import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/lucide.dart';
import '../../models/user.dart';
import '../../ressources/app_colors.dart';
import '../../ressources/app_spacing.dart';
import '../../ressources/app_text_styles.dart';
import '../auth/login_view.dart';
import '../history/history_view.dart';
import '../listings/listings_view.dart';
import '../payments/payments_view.dart';
import '../settings/settings_view.dart';
import '../widgets/badges/domus_badge.dart';
import '../widgets/buttons/secondary_button.dart';

/// Vue — Profil : informations personnelles, accès aux sections du compte.
class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final user = AppUser.demo;
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 110),
        children: [
          Row(
            children: [
              ClipRRect(borderRadius: BorderRadius.circular(20), child: Image.network(user.avatarUrl, width: 66, height: 66, fit: BoxFit.cover)),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(user.fullName, style: AppTextStyles.h3),
                    Text(user.phone, style: AppTextStyles.bodySm),
                    const SizedBox(height: 6),
                    if (user.isVerified) const StatusPill(label: 'Compte vérifié', color: AppColors.success),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          Row(
            children: [
              _stat('${user.listingsCount}', 'Annonces'),
              const SizedBox(width: 10),
              _stat('${user.favoritesCount}', 'Favoris'),
              const SizedBox(width: 10),
              _stat('${user.visitsCount}', 'Visites'),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          _menuTile(context, Lucide.building_2, 'Mes annonces', () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ListingsView()))),
          _menuTile(context, Lucide.history, 'Historique', () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const HistoryView()))),
          _menuTile(context, Lucide.wallet, 'Paiements', () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const PaymentsView()))),
          _menuTile(context, Lucide.settings, 'Paramètres', () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const SettingsView()))),
          const SizedBox(height: AppSpacing.md),
          SecondaryButton(
            label: 'Déconnexion',
            icon: Lucide.log_out,
            color: AppColors.error,
            onPressed: () => Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => const LoginView()), (r) => false),
          ),
        ],
      ),
    );
  }

  Widget _stat(String value, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(color: Colors.white, border: Border.all(color: AppColors.border), borderRadius: BorderRadius.circular(16)),
        child: Column(
          children: [
            Text(value, style: AppTextStyles.h3.copyWith(color: AppColors.primary)),
            Text(label, style: AppTextStyles.caption),
          ],
        ),
      ),
    );
  }

  Widget _menuTile(BuildContext context, String icon, String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.border))),
        child: Row(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(12)),
              child: Iconify(icon, size: 17, color: AppColors.primary),
            ),
            const SizedBox(width: 14),
            Expanded(child: Text(label, style: AppTextStyles.bodyMd.copyWith(fontWeight: FontWeight.w600))),
            const Iconify(Lucide.chevron_right, size: 16, color: AppColors.textSecondary),
          ],
        ),
      ),
    );
  }
}
