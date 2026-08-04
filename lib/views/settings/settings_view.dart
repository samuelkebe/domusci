import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../resources/color.dart';
import '../../utils/langue_provider.dart';
import '../../utils/theme_provider.dart';

class SettingView extends StatefulWidget {
  const SettingView({super.key});

  @override
  State<SettingView> createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  final List<String> _langues = ['Français', 'English'];

  String _getLanguageLabel(Locale locale) {
    switch (locale.languageCode) {
      case 'fr':
        return 'Français';
      case 'en':
        return 'English';
      default:
        return 'Français';
    }
  }

  Future<void> _initAppInfo() async {
    // await appInfoService.init();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final langueProvider = Provider.of<LanguageProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    final isFrench = langueProvider.locale.languageCode == 'fr';

    return Scaffold(
      // Supprimer backgroundColor pour laisser le Container gérer tout
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFEAF5DE),
              Color(0xFFF7FAF2),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ======================
                // SECTION : PRÉFÉRENCES
                // ======================
                Text(
                  isFrench ? 'Préférences' : 'Preferences',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : Colors.black87, // Ajout de couleur explicite
                  ),
                ),
                const SizedBox(height: 8),
                Card(
                  elevation: 2, // Légère élévation pour meilleur rendu
                  color: isDarkMode ? Colors.grey[850] : Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      // LANGUE
                      ExpansionTile(
                        tilePadding: const EdgeInsets.symmetric(horizontal: 16),
                        leading: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            Icons.language,
                            color: AppColors.primaryColor,
                            size: 22,
                          ),
                        ),
                        title: Text(
                          isFrench ? 'Langue' : 'Language',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: isDarkMode ? Colors.white : Colors.black87,
                          ),
                        ),
                        subtitle: Text(
                          _getLanguageLabel(langueProvider.locale),
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                          ),
                        ),
                        backgroundColor: Colors.transparent, // Pour éviter un fond blanc
                        children: _langues.map((lang) {
                          final isSelected = _getLanguageLabel(langueProvider.locale) == lang;
                          return SwitchListTile(
                            title: Text(
                              lang,
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: isDarkMode ? Colors.white : Colors.black87,
                              ),
                            ),
                            value: isSelected,
                            activeColor: AppColors.primaryColor,
                            onChanged: (value) {
                              if (value) langueProvider.changeLanguage(lang);
                            },
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),
                // ======================
                // SECTION : SUPPORT
                // ======================
                Text(
                  isFrench ? 'Support & Informations' : 'Support & Information',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                Card(
                  elevation: 2,
                  color: isDarkMode ? Colors.grey[850] : Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      // CENTRE D'AIDE
                      ListTile(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                        leading: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            Icons.help_outline,
                            color: AppColors.primaryColor,
                            size: 22,
                          ),
                        ),
                        title: Text(
                          isFrench ? 'Centre d\'aide' : 'Help Center',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: isDarkMode ? Colors.white : Colors.black87,
                          ),
                        ),
                        subtitle: Text(
                          isFrench ? 'FAQ et assistance' : 'FAQ and support',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                          ),
                        ),
                        trailing: Icon(
                          Icons.chevron_right,
                          color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                        ),
                        // onTap: () => context.push(AppRouteName.page, extra: const AssistanceView()),
                      ),
                      const Divider(height: 1, indent: 56),

                      // CONDITIONS D'UTILISATION
                      ListTile(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                        leading: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            Icons.description_outlined,
                            color: AppColors.primaryColor,
                            size: 22,
                          ),
                        ),
                        title: Text(
                          isFrench ? 'Conditions d\'utilisation' : 'Terms of use',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: isDarkMode ? Colors.white : Colors.black87,
                          ),
                        ),
                        subtitle: Text(
                          isFrench ? 'Lire les conditions' : 'Read terms',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                          ),
                        ),
                        trailing: Icon(
                          Icons.chevron_right,
                          color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
