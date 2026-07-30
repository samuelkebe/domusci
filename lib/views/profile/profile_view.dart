import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../../components/primary_button.dart';
import '../../resources/color.dart';
import '../../utils/langue_provider.dart';
import '../../utils/theme_provider.dart';
import '../../views-models/auth_view_model.dart';

class ProfilView extends StatefulWidget {
  const ProfilView({super.key});

  @override
  State<ProfilView> createState() => _ProfilViewState();
}

class _ProfilViewState extends State<ProfilView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    final isFrench = Provider.of<LanguageProvider>(context).locale.languageCode == 'fr';

    return Scaffold(
      backgroundColor: isDarkMode ? AppColors.black2 : Colors.white,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDarkMode
                ? [
              AppColors.black2,
              Colors.grey[900]!,
            ]
                : [
              const Color(0xFFEAF5DE),
              const Color(0xFFF7FAF2),
            ],
          ),
        ),
        child: SafeArea(
          child: Consumer<AuthViewModel>(
            builder: (context, authViewModel, child) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // BOUTON RETOUR
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: isDarkMode ? Colors.grey[800] : Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              blurRadius: 10,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: isDarkMode ? Colors.white : const Color(0xFF1E2022),
                          size: 20,
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // AVATAR + NOM
                    Center(
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.green2,
                                width: 3,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.primaryColor.withOpacity(0.3),
                                  blurRadius: 20,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: CircleAvatar(
                              radius: 45,
                              backgroundColor: AppColors.green,
                              child: Text(
                                _getUserInitials("Domus CI"),
                                style:  Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "Domus CI",
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: isDarkMode ? Colors.white : Colors.black87,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                        ],
                      ),
                    ),

                    const SizedBox(height: 32),

                    // CARTE INFORMATIONS
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: isDarkMode ? Colors.grey[850] : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.06),
                            blurRadius: 20,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Titre de la carte
                          Row(
                            children: [
                              Icon(
                                Icons.person_outline,
                                color: AppColors.primaryColor,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                isFrench ? "Informations personnelles" : "Personal information",
                                style: TextStyle(
                                  color: isDarkMode ? Colors.white : Colors.black87,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          const Divider(),
                          const SizedBox(height: 16),

                          // Adresse
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: AppColors.primaryColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Icon(
                                  Icons.location_on_outlined,
                                  color: AppColors.primaryColor,
                                  size: 20,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      isFrench ? "Adresse" : "Address",
                                      style: TextStyle(
                                        color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      "Abidjan, Côte d'Ivoire",
                                      style: TextStyle(
                                        color: isDarkMode ? Colors.white : Colors.black87,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 16),
                          const Divider(),
                          const SizedBox(height: 16),

                          // Email
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: AppColors.primaryColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Icon(
                                  Icons.email_outlined,
                                  color: AppColors.primaryColor,
                                  size: 20,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Email",
                                      style: TextStyle(
                                        color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      "contact@domus.ci",
                                      style: TextStyle(
                                        color: isDarkMode ? Colors.white : Colors.black87,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 16),
                          const Divider(),
                          const SizedBox(height: 16),

                          // Téléphone
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: AppColors.primaryColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Icon(
                                  Icons.phone_outlined,
                                  color: AppColors.primaryColor,
                                  size: 20,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      isFrench ? "Téléphone" : "Phone",
                                      style: TextStyle(
                                        color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      "+225 05 05 05 05 05",
                                      style: TextStyle(
                                        color: isDarkMode ? Colors.white : Colors.black87,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Card(
                    //   elevation: 2,
                    //   color: isDarkMode ? Colors.grey[850] : Colors.white,
                    //   shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.circular(16),
                    //   ),
                    //   child: Column(
                    //     children: [
                    //       // CENTRE D'AIDE
                    //       ListTile(
                    //         contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    //         leading: Container(
                    //           padding: const EdgeInsets.all(8),
                    //           decoration: BoxDecoration(
                    //             color: AppColors.primaryColor.withOpacity(0.1),
                    //             borderRadius: BorderRadius.circular(10),
                    //           ),
                    //           child: Icon(
                    //             Icons.person_outline,
                    //             color: AppColors.primaryColor,
                    //             size: 20,
                    //           ),
                    //         ),
                    //         title: Text(
                    //           isFrench ? 'Centre d\'aide' : 'Help Center',
                    //           style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    //             fontWeight: FontWeight.w600,
                    //             color: isDarkMode ? Colors.white : Colors.black87,
                    //           ),
                    //         ),
                    //         subtitle: Text(
                    //           isFrench ? 'FAQ et assistance' : 'FAQ and support',
                    //           style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    //             color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                    //           ),
                    //         ),
                    //         trailing: Icon(
                    //           Icons.chevron_right,
                    //           color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                    //         ),
                    //         // onTap: () => context.push(AppRouteName.page, extra: const AssistanceView()),
                    //       ),
                    //       const Divider(height: 1, indent: 56),
                    //
                    //       // CONDITIONS D'UTILISATION
                    //       ListTile(
                    //         contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    //         leading: Container(
                    //           padding: const EdgeInsets.all(8),
                    //           decoration: BoxDecoration(
                    //             color: AppColors.primaryColor.withOpacity(0.1),
                    //             borderRadius: BorderRadius.circular(10),
                    //           ),
                    //           child: Icon(
                    //             Icons.description_outlined,
                    //             color: AppColors.primaryColor,
                    //             size: 22,
                    //           ),
                    //         ),
                    //         title: Text(
                    //           isFrench ? 'Conditions d\'utilisation' : 'Terms of use',
                    //           style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    //             fontWeight: FontWeight.w600,
                    //             color: isDarkMode ? Colors.white : Colors.black87,
                    //           ),
                    //         ),
                    //         subtitle: Text(
                    //           isFrench ? 'Lire les conditions' : 'Read terms',
                    //           style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    //             color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                    //           ),
                    //         ),
                    //         trailing: Icon(
                    //           Icons.chevron_right,
                    //           color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),

                    const SizedBox(height: 20),
                  ],
                ),
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          color: isDarkMode ? AppColors.black2 : Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: SizedBox(
            width: double.infinity,
            height: 50,
            child: PrimaryButton(
              title: isFrench ? "Se désinscrire" : "Unenroll",
              onPressed: () {
                showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (context) {
                    final formKey = GlobalKey<FormState>();
                    final TextEditingController commentController = TextEditingController();

                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      title: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.red.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.warning_amber_rounded,
                              color: Colors.red,
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              isFrench ? 'Confirmation de désinscription' : 'Unenroll confirmation',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                      content: Form(
                        key: formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              isFrench
                                  ? 'Veuillez nous indiquer la raison de votre désinscription :'
                                  : 'Please tell us the reason for your unenrollment:',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: commentController,
                              maxLines: 4,
                              decoration: InputDecoration(
                                hintText: isFrench ? "Votre commentaire..." : "Your comment...",
                                hintStyle: TextStyle(color: Colors.grey[400]),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(color: Colors.grey[300]!),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(color: AppColors.primaryColor, width: 2),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(color: Colors.grey[200]!),
                                ),
                                filled: true,
                                fillColor: Colors.grey[50],
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return isFrench
                                      ? 'Veuillez entrer un commentaire'
                                      : 'Please enter a comment';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.grey[600],
                          ),
                          child: Text(isFrench ? 'Annuler' : 'Cancel'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    isFrench
                                        ? 'Votre demande de désinscription a été envoyée'
                                        : 'Your unenrollment request has been sent',
                                  ),
                                  backgroundColor: Colors.green,
                                  duration: const Duration(seconds: 3),
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(isFrench ? 'Confirmer' : 'Confirm'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  String _getUserInitials(String? userMerchantName) {
    if (userMerchantName == null || userMerchantName.isEmpty) return "";

    final words = userMerchantName.trim().split(' ');
    final initials = words
        .where((word) => word.isNotEmpty)
        .map((word) => word[0].toUpperCase())
        .join();

    return initials.length > 3 ? initials.substring(0, 3) : initials;
  }
}