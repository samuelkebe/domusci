import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/lucide.dart';
import '../../ressources/app_colors.dart';
import '../../ressources/app_spacing.dart';
import '../../ressources/app_text_styles.dart';
import '../widgets/app_bar/domus_app_bar.dart';

/// Vue — Paramètres : mode sombre, langue, notifications, sécurité, aide.
class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  bool _darkMode = false;
  final Map<String, bool> _notifPrefs = {
    'Nouvelles annonces': true,
    'Messages': true,
    'Baisses de prix': true,
    'Rappels de visite': true,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DomusAppBar(title: 'Paramètres'),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 6, 20, 24),
        children: [
          _sectionLabel('Préférences'),
          _card([
            _switchTile(Lucide.moon, 'Mode sombre', _darkMode, (v) => setState(() => _darkMode = v)),
            _navTile(Lucide.globe, 'Langue', trailing: 'Français'),
          ]),
          const SizedBox(height: AppSpacing.lg),
          _sectionLabel('Notifications'),
          _card(_notifPrefs.entries
              .map((e) => _switchTile(Lucide.bell, e.key, e.value, (v) => setState(() => _notifPrefs[e.key] = v)))
              .toList()),
          const SizedBox(height: AppSpacing.lg),
          _sectionLabel('Compte'),
          _card([
            _navTile(Lucide.shield, 'Sécurité et confidentialité'),
            _navTile(Lucide.help_circle, "Centre d'aide"),
            _navTile(Lucide.info, 'À propos de Domus CI'),
          ]),
        ],
      ),
    );
  }

  Widget _sectionLabel(String label) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(label.toUpperCase(), style: AppTextStyles.caption.copyWith(letterSpacing: 0.6)),
      );

  Widget _card(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.border)),
      child: Column(children: children),
    );
  }

  Widget _switchTile(String icon, String label, bool value, ValueChanged<bool> onChanged) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.border))),
      child: Row(
        children: [
          Container(width: 36, height: 36, decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(11)), child: Iconify(icon, size: 16, color: AppColors.primary)),
          const SizedBox(width: 12),
          Expanded(child: Text(label, style: AppTextStyles.bodyMd.copyWith(fontWeight: FontWeight.w600))),
          Switch(value: value, onChanged: onChanged, activeColor: AppColors.primary),
        ],
      ),
    );
  }

  Widget _navTile(String icon, String label, {String? trailing}) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.border))),
      child: Row(
        children: [
          Container(width: 36, height: 36, decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(11)), child: Iconify(icon, size: 16, color: AppColors.primary)),
          const SizedBox(width: 12),
          Expanded(child: Text(label, style: AppTextStyles.bodyMd.copyWith(fontWeight: FontWeight.w600))),
          if (trailing != null) Text(trailing, style: AppTextStyles.bodySm),
          const SizedBox(width: 6),
          const Iconify(Lucide.chevron_right, size: 15, color: AppColors.textSecondary),
        ],
      ),
    );
  }
}
