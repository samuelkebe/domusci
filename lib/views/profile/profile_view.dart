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

    WidgetsBinding.instance.addPostFrameCallback((_) {
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Consumer<AuthViewModel>(
        builder: (context, value, child) {

          return Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                /// Avatar + Nom
                Center(
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: AppColors.primaryColor,
                        child: Text(
                          getUserInitials( "AB"),
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                         "Domus CI",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                /// Container Informations
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: isDarkMode ? AppColors.black2 : AppColors.lighgrey,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      /// Adresse
                      Text(
                        "Adresse",
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: Colors.grey),
                      ),
                      const SizedBox(height: 4),
                      Text(
                         "",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),

                      const SizedBox(height: 16),
                      Divider(color: Colors.grey.withOpacity(0.2)),
                      const SizedBox(height: 16),

                      /// Email
                      Text(
                        "Email",
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: Colors.grey),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),

                      const SizedBox(height: 16),
                      Divider(color: Colors.grey.withOpacity(0.2)),
                      const SizedBox(height: 16),

                      /// Téléphone
                      Text(
                        "Téléphone",
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: Colors.grey),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],            ),
          );
        },
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
          child: SizedBox(
            width: double.infinity,
            height: 50,
            child: PrimaryButton(
              title: "Se désenroler",
              onPressed: () {
                showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (context) {
                    // Créer une GlobalKey pour le formulaire dans le dialog
                    final formKey = GlobalKey<FormState>();
                    final TextEditingController numeroContribuableController = TextEditingController();

                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      title: Text(
                        'Prière rentrez un commentaire.',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.black,
                        ),
                      ),
                      content: Form(
                        key: formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextField(
                              // controller: assistanceViewModel.commentaireController,
                              maxLines: 5,
                              decoration: InputDecoration(
                                hintText: "",
                                hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: Colors.black.withOpacity(0.6),
                                ),
                                labelText: "Votre commentaire",
                                labelStyle: Theme.of(context).textTheme.bodyMedium,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: AppColors.primaryColor
                                    )

                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              width: double.infinity,
                              child: PrimaryButton(
                                onPressed: () async {
                                  /**
                                   * Logique pour désenroler le marchand
                                   */
                                  if (formKey.currentState!.validate()) {
                                    // context.push(AppRouteName.page, extra: const OnBoardingView());
                                  }

                                },
                                title: 'Valider',
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            // child: ElevatedButton.icon(
            //   icon: const Icon(Icons.logout),
            //   label: const Text("Se déconnecter"),
            //   style: ElevatedButton.styleFrom(
            //     backgroundColor: Colors.red,
            //   ),
            //   onPressed: () {
            //     Navigator.of(context).pushNamedAndRemoveUntil(
            //       '/login',
            //           (route) => false,
            //     );
            //   },
            // ),
          ),
        ),
      ),

    );
  }
}
String getUserInitials(String? userMerchantName) {
  if (userMerchantName == null || userMerchantName.isEmpty) return "";

  // Découper le nom par les espaces
  final words = userMerchantName.split(' ');

  // Prendre la première lettre de chaque mot
  final initials = words.map((word) => word.isNotEmpty ? word[0].toUpperCase() : '').join();

  // Si tu veux seulement les deux premières lettres (deux premiers mots)
  return initials.length > 2 ? initials.substring(0, 3) : initials;
}


