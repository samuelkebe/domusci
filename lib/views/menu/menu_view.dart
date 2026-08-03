import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../../components/primary_button.dart';
import '../../components/showLoadingSession.dart';
import '../../components/showResponsiveBottomSheet.dart';
import '../../resources/color.dart';
import '../../utils/langue_provider.dart';
import '../../utils/theme_provider.dart';
import '../../views-models/auth_view_model.dart';

class MenuView extends StatefulWidget {
  const MenuView({super.key});

  @override
  State<MenuView> createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> {
  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) async {
    //   final viewModel = Provider.of<AuthViewModel>(
    //     context,
    //     listen: false,
    //   );
    //   viewModel.getMerchantConnected();
    //   // instrumentPaiementviewModel.getGrillesRepartitions();
    // });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final langueProvider = Provider.of<LanguageProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    final isFrench = langueProvider.locale.languageCode == 'fr';

    return Scaffold(
      backgroundColor: isDarkMode ? AppColors.black2 : const Color(0xFFF7FAF2),
      body: Consumer<AuthViewModel>(builder: (context, value, child) {
        return Stack(
          children: [
            if (!isDarkMode)
              Positioned.fill(
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xFFEAF5DE), Color(0xFFF7FAF2)],
                    ),
                  ),
                ),
              ),
            SafeArea(
              child: Column(
                children: [
                  /// ======================
                  /// HEADER FIXE
                  /// ======================
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isDarkMode ? AppColors.black2 : Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.06),
                                blurRadius: 14,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: CircleAvatar(
                            radius: 26,
                            backgroundColor: AppColors.black,
                            child: Text(
                              getUserInitials("FB"),
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "",
                                style: Theme.of(context).textTheme.titleMedium
                                    ?.copyWith(
                                  fontWeight: FontWeight.w800,
                                  color: isDarkMode ? AppColors.white : const Color(0xFF1E2022),
                                  letterSpacing: -0.2,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE1F57A),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  "DEMARCHEUR",
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: const Color(0xFF1E2022),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 10.5,
                                    letterSpacing: 0.3,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          borderRadius: BorderRadius.circular(24),
                          onTap: () {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) {
                                final isDarkMode = Theme.of(context).brightness == Brightness.dark;

                                return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  backgroundColor: Theme.of(context).cardColor,

                                  title: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        "Déconnexion",
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),

                                  content: Text(
                                    "Voulez-vous vraiment vous déconnecter ?",
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      height: 1.4,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface
                                          .withOpacity(0.7),
                                    ),
                                  ),

                                  actionsAlignment: MainAxisAlignment.spaceEvenly,

                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      style: TextButton.styleFrom(
                                        foregroundColor: Colors.black,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                      ),
                                      child: const Text("Annuler"),
                                    ),

                                    ElevatedButton(
                                      onPressed: () async {
                                        // Navigator.pop(context);
                                        //
                                        // final authVm =
                                        // Provider.of<AuthViewModel>(context, listen: false);
                                        // final sessionVm = Provider.of<SessionManagerViewModel>(context, listen: false);
                                        //
                                        // showLoadingSession(context);
                                        //
                                        // await authVm.logout();
                                        //  sessionVm.logout();
                                        //
                                        // if (context.mounted) {
                                        //   context.go(AppRouteName.login);
                                        // }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.red,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                      ),
                                      child: const Text(
                                        "Déconnexion",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Container(
                            width: 46,
                            height: 46,
                            decoration: BoxDecoration(
                              color: AppColors.red.withOpacity(0.08),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.logout_rounded, color: AppColors.red, size: 20),
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// ======================
                  /// CONTENU SCROLLABLE
                  /// ======================
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 12),
                          _SectionLabel(text: isFrench ? "Compte" : "Account", isDarkMode: isDarkMode),
                          const SizedBox(height: 10),
                          Container(
                            decoration: BoxDecoration(
                              color: isDarkMode ? AppColors.black : Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              // boxShadow: [
                              //   BoxShadow(
                              //     color: const Color(0xFFE1F57A).withOpacity(0.35),
                              //     blurRadius: 18,
                              //     offset: const Offset(0, 8),
                              //   ),
                              // ],
                            ),
                            child: Column(
                              children: [
                                _MenuTile(
                                  icon: Icons.person_rounded,
                                  iconColor: const Color(0xFF1E2022),
                                  iconBackground: Colors.white,
                                  title: isFrench ? "Mon profil" : "My profile",
                                  subtitle: isFrench
                                      ? "Gérez les informations de votre compte"
                                      : "Manage your account information",
                                  titleColor: isDarkMode ? AppColors.white : AppColors.black,
                                  subtitleColor: isDarkMode ? AppColors.white : AppColors.black,
                                  trailingColor: isDarkMode ? AppColors.white : AppColors.black,
                                  onTap: () {
                                    // context.push(AppRouteName.page, extra: const ProfilView());
                                  },
                                ),

                                // const Divider(height: 1),
                                // ListTile(
                                //   title: Text(
                                //     isFrench ? "Historique d’abonnements" : "Subscriptions History",
                                //     style: Theme.of(context).textTheme.bodyMedium
                                //         ?.copyWith(
                                //       fontWeight: FontWeight.w600,
                                //       color: isDarkMode
                                //           ? AppColors.white
                                //           : AppColors.black,
                                //     ),
                                //   ),
                                //   subtitle: Text(
                                //     isFrench ? "Consultez vos  abonnements" : "View your subscriptions",
                                //     style: Theme.of(context).textTheme.bodySmall
                                //         ?.copyWith(
                                //       color: isDarkMode
                                //           ? AppColors.white
                                //           : AppColors.black,
                                //     ),
                                //   ),
                                //   trailing: const Icon(Icons.chevron_right),
                                //   onTap: () {},
                                // ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),

                          /// ======================
                          /// SECTION : SERVICES
                          /// ======================
                          _SectionLabel(text: isFrench ? "Annonces" : "Subscription", isDarkMode: isDarkMode),
                          const SizedBox(height: 10),
                          Container(
                            decoration: BoxDecoration(
                              color: isDarkMode ? AppColors.black : Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: isDarkMode
                                  ? []
                                  : [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.04),
                                  blurRadius: 16,
                                  offset: const Offset(0, 6),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                _MenuTile(
                                  icon: Icons.description_outlined,
                                  iconColor: const Color(0xFF1E2022),
                                  iconBackground: const Color(0xFFF7F9F5),
                                  title: isFrench ? "Mes annonces" : " ",
                                  subtitle: isFrench
                                      ? "Gérer mes annonces"
                                      : "",
                                  onTap: () {},
                                ),


                              ],
                            ),
                          ),
                          const SizedBox(height: 24),

                          // /// ======================
                          // /// SECTION : SUPPORT
                          // /// ======================
                          // Card(
                          //   elevation: 0,
                          //   color: isDarkMode ? AppColors.black : AppColors.lighgrey,
                          //   shape: RoundedRectangleBorder(
                          //     borderRadius: BorderRadius.circular(16),
                          //   ),
                          //   child: Column(
                          //     children: [
                          //       ListTile(
                          //         title: Text(
                          //           "Noter l’application",
                          //           style: Theme.of(context).textTheme.bodyMedium
                          //               ?.copyWith(fontWeight: FontWeight.w600),
                          //         ),
                          //         subtitle: Text(
                          //           "Donnez votre avis",
                          //           style: Theme.of(
                          //             context,
                          //           ).textTheme.bodySmall?.copyWith(),
                          //         ),
                          //         trailing: const Icon(Icons.chevron_right),
                          //         onTap: () {},
                          //       ),
                          //       const Divider(height: 1),
                          //       ListTile(
                          //         title: Text(
                          //           "Assistance",
                          //           style: Theme.of(context).textTheme.bodyMedium
                          //               ?.copyWith(fontWeight: FontWeight.w600),
                          //         ),
                          //         subtitle: Text(
                          //           "Contactez notre service support",
                          //           style: Theme.of(
                          //             context,
                          //           ).textTheme.bodySmall?.copyWith(),
                          //         ),
                          //         trailing: const Icon(Icons.chevron_right),
                          //         onTap: () {
                          //           Navigator.push(
                          //             context,
                          //             MaterialPageRoute(
                          //               builder: (context) {
                          //                 return AssistanceView();
                          //               },
                          //             ),
                          //           );
                          //         },
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          // const SizedBox(height: 16),

                          /// ======================
                          /// SECTION : DANGER
                          /// ======================
                          _SectionLabel(
                            text: isFrench ? "DESINSCRIPTION" : "",
                            isDarkMode: isDarkMode,
                            color: AppColors.red,
                          ),
                          const SizedBox(height: 10),
                          Container(
                            decoration: BoxDecoration(
                              color: isDarkMode ? AppColors.black : Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: AppColors.red.withOpacity(0.15)),
                              boxShadow: isDarkMode
                                  ? []
                                  : [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.03),
                                  blurRadius: 14,
                                  offset: const Offset(0, 6),
                                ),
                              ],
                            ),
                            child: _MenuTile(
                              icon: Icons.person_remove_rounded,
                              iconColor: AppColors.red,
                              iconBackground: AppColors.red.withOpacity(0.08),
                              title: isFrench ? "Se désinscrire" : "Unsubscribe",
                              subtitle: isFrench
                                  ? "Supprimez définitivement le compte"
                                  : "Delete the account permanently",
                              titleColor: Colors.red,
                              // onTap: () {
                              //   showDialog(
                              //     context: context,
                              //     barrierDismissible: true,
                              //     builder: (context) {
                              //       final formKey = GlobalKey<FormState>();
                              //       final marchandVm = Provider.of<CommercantViewModel>(context, listen: false);
                              //
                              //       return AlertDialog(
                              //         shape: RoundedRectangleBorder(
                              //           borderRadius: BorderRadius.circular(12),
                              //         ),
                              //         title: Text(
                              //           'Prière rentrer un commentaire.',
                              //           style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              //             fontWeight: FontWeight.bold,
                              //             color: AppColors.black,
                              //           ),
                              //         ),
                              //         content: SizedBox(
                              //           width: MediaQuery.of(context).size.width * 0.8, // largeur élargie
                              //           child: Form(
                              //             key: formKey,
                              //             child: Column(
                              //               mainAxisSize: MainAxisSize.min,
                              //               children: [
                              //                 TextFormField(
                              //                   controller: marchandVm.commentaireController,
                              //                   maxLines: 5,
                              //                   decoration: InputDecoration(
                              //                     hintText: "",
                              //                     hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              //                       color: Colors.black.withOpacity(0.6),
                              //                     ),
                              //                     labelText: "Votre commentaire",
                              //                     labelStyle: Theme.of(context).textTheme.bodyMedium,
                              //                     border: OutlineInputBorder(
                              //                       borderRadius: BorderRadius.circular(10),
                              //                       borderSide: BorderSide(color: AppColors.primaryColor),
                              //                     ),
                              //                     focusedBorder: OutlineInputBorder(
                              //                       borderRadius: BorderRadius.circular(10),
                              //                       borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
                              //                     ),
                              //                   ),
                              //                   validator: (value) {
                              //                     if (value == null || value.trim().isEmpty) {
                              //                       return "Le commentaire est requis";
                              //                     }
                              //                     return null;
                              //                   },
                              //                 ),
                              //                 const SizedBox(height: 20),
                              //                 SizedBox(
                              //                   width: double.infinity,
                              //                   child: PrimaryButton(
                              //                     onPressed: () async {
                              //                       // Vérifier acceptation des conditions
                              //
                              //
                              //                       // Valider le formulaire
                              //                       if (formKey.currentState!.validate()) {
                              //                         Navigator.push(
                              //                           context,
                              //                           MaterialPageRoute(
                              //                             builder: (context) => const OnBoardingView(),
                              //                           ),
                              //                         );
                              //                       }
                              //                     },
                              //                     title: 'Valider',
                              //                   ),
                              //                 ),
                              //               ],
                              //             ),
                              //           ),
                              //         ),
                              //       );
                              //     },
                              //   );
                              // },
                              onTap: () {
                                // final marchandVm = Provider.of<MarchandViewmodel>(
                                //   context,
                                //   listen: false,
                                // );
                                //
                                // final formKey = GlobalKey<FormState>();
                                //
                                // showResponsiveBottomSheet(
                                //   context,
                                //   SafeArea(
                                //     child: Padding(
                                //       padding: EdgeInsets.only(
                                //         left: 20,
                                //         right: 20,
                                //         top: 20,
                                //         bottom:
                                //         MediaQuery.of(context).viewInsets.bottom +
                                //             20,
                                //       ),
                                //       child: SingleChildScrollView(
                                //         child: Form(
                                //           key: formKey,
                                //           child: Column(
                                //             mainAxisSize: MainAxisSize.min,
                                //             crossAxisAlignment:
                                //             CrossAxisAlignment.start,
                                //             children: [
                                //               /// Titre
                                //               Center(
                                //                 child: Text(
                                //                   isFrench ? "Prière rentrer un commentaire." : "Please enter a comment.",
                                //                   style: Theme.of(context)
                                //                       .textTheme
                                //                       .bodyLarge
                                //                       ?.copyWith(
                                //                     fontWeight: FontWeight.bold,
                                //                   ),
                                //                 ),
                                //               ),
                                //
                                //               const SizedBox(height: 25),
                                //
                                //               /// Champ commentaire
                                //               TextFormField(
                                //                 controller:
                                //                 marchandVm.commentaireController,
                                //                 maxLines: 5,
                                //                 decoration: InputDecoration(
                                //                   labelText: isFrench ? "Votre commentaire" : "Your comment",
                                //                   labelStyle: Theme.of(
                                //                     context,
                                //                   ).textTheme.bodyMedium,
                                //                   border: OutlineInputBorder(
                                //                     borderRadius:
                                //                     BorderRadius.circular(12),
                                //                     borderSide: BorderSide(
                                //                       color: AppColors.primaryColor,
                                //                     ),
                                //                   ),
                                //                   focusedBorder: OutlineInputBorder(
                                //                     borderRadius:
                                //                     BorderRadius.circular(12),
                                //                     borderSide: BorderSide(
                                //                       color: AppColors.primaryColor,
                                //                       width: 2,
                                //                     ),
                                //                   ),
                                //                 ),
                                //                 validator: (value) {
                                //                   if (value == null ||
                                //                       value.trim().isEmpty) {
                                //                     return isFrench ? "Le commentaire est requis" : "Comment is required";
                                //                   }
                                //                   return null;
                                //                 },
                                //               ),
                                //
                                //               const SizedBox(height: 30),
                                //
                                //               /// Bouton
                                //               SizedBox(
                                //                 width: double.infinity,
                                //                 child: PrimaryButton(
                                //                   title: isFrench ? "Valider" : "Submit",
                                //                   onPressed: () {
                                //                     if (formKey.currentState!
                                //                         .validate()) {
                                //                       Navigator.pop(
                                //                         context,
                                //                       ); // Ferme le bottomSheet
                                //
                                //                       context.push(AppRouteName.page, extra: const OnBoardingView());
                                //                     }
                                //                   },
                                //                 ),
                                //               ),
                                //             ],
                                //           ),
                                //         ),
                                //       ),
                                //     ),
                                //   ),
                                // );
                              },
                            ),
                          ),
                          const SizedBox(height: 32),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },),
    );
  }
}

/// Small caps label placed above each Card group, used purely to
/// improve visual grouping/hierarchy — no navigation or state attached.
class _SectionLabel extends StatelessWidget {
  final String text;
  final bool isDarkMode;
  final Color? color;

  const _SectionLabel({required this.text, required this.isDarkMode, this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text(
        text.toUpperCase(),
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          fontWeight: FontWeight.bold,
          letterSpacing: 0.6,
          color: color ?? (isDarkMode ? AppColors.white : AppColors.black),
        ),
      ),
    );
  }
}

/// Replaces the bare ListTile rows with an icon badge + refined spacing,
/// while keeping the exact same title/subtitle/trailing/onTap contract.
class _MenuTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBackground;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;
  final Color? titleColor;
  final Color? subtitleColor;
  final Color? trailingColor;

  const _MenuTile({
    required this.icon,
    required this.iconColor,
    required this.iconBackground,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.titleColor,
    this.subtitleColor,
    this.trailingColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(color: iconBackground, borderRadius: BorderRadius.circular(13)),
              child: Icon(icon, size: 19, color: iconColor),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: titleColor,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: subtitleColor ?? Colors.grey[500],
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right_rounded, color: trailingColor ?? Colors.grey[400], size: 20),
          ],
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