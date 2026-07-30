import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/lucide.dart';
import 'package:provider/provider.dart';
import '../../components/input.dart';
import '../../components/primary_button.dart';
import '../../resources/color.dart';
import '../../views-models/auth_view_model.dart';
import '../home/home_shell_view.dart';

/// Vue — Connexion (Google, Apple, téléphone/mot de passe).
class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  @override
  void initState() {
    super.initState();

    // Charger les données du ViewModel à l'init
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authViewModel = Provider.of<AuthViewModel>(context, listen: false,);
      // authViewModel.resetForm();
    });
  }

  bool _obscureText = true;
  final _formKey = GlobalKey<FormState>();

  void _togglePasswordView() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      // body: Consumer<AuthViewModel>(
      //   builder: (context, authViewModel, child) {
      //     return Center(
      //       child: SingleChildScrollView(
      //         padding: const EdgeInsets.all(24.0),
      //         child: Form(
      //           key: _formKey,
      //           child: Column(
      //             mainAxisAlignment: MainAxisAlignment.center,
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             children: [
      //               // Logo
      //               // Image.asset(
      //               //   'assets/images/logo_horizontal_1.png',
      //               //   width: 171,
      //               //   height: 50,
      //               // ),
      //               Align(
      //                 alignment: Alignment.centerLeft,
      //                 child: Row(
      //                   mainAxisSize: MainAxisSize.min,
      //                   children: [
      //                     Text(
      //                       'Unitec',
      //                       style: Theme.of(context).textTheme.titleLarge
      //                           ?.copyWith(
      //                         fontWeight: FontWeight.bold,
      //                         fontSize: 30,
      //                         color: AppColors.blackColor,
      //                       ),
      //                     ),
      //                     SizedBox(width: 8),
      //                     Icon(
      //                       CupertinoIcons.bag,
      //                       size: 50,
      //                       color: AppColors.blackColor,
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //
      //               const SizedBox(height: 50),
      //
      //               // Texte juste en dessous
      //               Text("Se connecter", style: Theme.of(context).textTheme.titleLarge),
      //               const SizedBox(height: 30),
      //
      //               // Champ login
      //               InputText(
      //                 controller: authViewModel.loginController,
      //                 labelText: "Login",
      //                 hintext: "Saisissez votre login",
      //                 obscureText: false,
      //                 validator: (value) {
      //                   if (value == null || value.isEmpty) {
      //                     return "Veuillez saisir votre login FNCE";
      //                   }
      //                   if (value.length != 10) {
      //                     return "Numéro FNCE invalide";
      //                   }
      //                   return null;
      //                 },
      //
      //               ),
      //               const SizedBox(height: 20),
      //
      //               // Champ mot de passe
      //               InputText(
      //                 controller: authViewModel.passwordController,
      //                 labelText: "Mot de passe",
      //                 hintext: "Saisissez votre mot de passe",
      //                 obscureText: _obscureText,
      //                 suffixIcon: IconButton(
      //                   icon: Icon(
      //                     _obscureText
      //                         ? Icons.visibility_off
      //                         : Icons.visibility,
      //                     color: Colors.grey,
      //                   ),
      //                   onPressed: _togglePasswordView,
      //                 ),
      //                 validator: (value) {
      //                   if (value == null || value.isEmpty) {
      //                     return "Veuillez saisir votre mot de passe ";
      //                   }
      //                   return null;
      //                 },
      //
      //               ),
      //               const SizedBox(height: 10),
      //
      //               // Mot de passe oublié
      //               Row(
      //                 mainAxisAlignment: MainAxisAlignment.end,
      //                 children: [
      //                   TextButton(
      //                     onPressed: () {
      //                       context.push(AppRouteName.page, extra: const MotDePasseOublieView());
      //                     },
      //                     child: Text(
      //                       'Mot de passe oublié ?',
      //                       style: Theme.of(context).textTheme.bodyMedium?.copyWith(
      //                         // fontSize: 14,
      //                         color: AppColors.blackColor,
      //                         fontWeight: FontWeight.w600,
      //                       ),
      //                     ),
      //                   ),
      //                 ],
      //               ),
      //               const SizedBox(height: 20),
      //
      //               Row(
      //                 mainAxisAlignment: MainAxisAlignment.center,
      //                 children: [
      //                   Text(
      //                     "Pas encore enrôlé ? ",
      //                     style: Theme.of(context).textTheme.bodyMedium
      //                         ?.copyWith(
      //                       fontSize: 14,
      //                       color: Colors.black.withOpacity(0.7),
      //                     ),
      //                   ),
      //                   TextButton(
      //                     onPressed: () {
      //                       context.push(AppRouteName.inscription);
      //                     },
      //                     child: Text(
      //                       "S'enrôler.",
      //                       style: Theme.of(context).textTheme.bodyMedium
      //                           ?.copyWith(
      //                         fontSize: 14,
      //                         color: AppColors.blackColor,
      //                         fontWeight: FontWeight.w600,
      //                       ),
      //                     ),
      //                   ),
      //                 ],
      //               ),
      //
      //               // Bouton connexion
      //
      //               // Option inscription
      //             ],
      //           ),
      //         ),
      //       ),
      //     );
      //   },
      // ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFEAF5DE), // Fond dégradé verdâtre doux en haut
              Color(0xFFF7FAF2),
            ],
          ),
        ),

        child: Consumer<AuthViewModel>(
          builder: (context, authVm, child) {
            return Form(
              key : _formKey,
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 400),
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: AppColors.green2,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Domus CI',
                                style: Theme.of(context).textTheme.titleLarge
                                    ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                  color: AppColors.black,
                                ),
                              ),
                              SizedBox(width: 8),
                              Icon(
                                CupertinoIcons.home,
                                size: 50,
                                color: AppColors.black,
                              ),
                            ],
                          ),
                          // child: Image.asset(
                          //   'assets/images/unitec-logo.jpg',
                          //   width: 200,
                          //   height: 100,
                          // ),
                        ),
                        const SizedBox(height: 50),

                        // Titre principal
                        Text(
                          "Se connecter",
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: AppColors.black,
                          ),
                        ),

                        const SizedBox(height: 8),

                        // Sous texte
                        Text(
                          "Entrez vos informations pour accéder à votre compte",
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 13,
                            color: Colors.grey.shade600,
                          ),
                        ),

                        const SizedBox(height: 30),

                        // Email
                        InputText(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Veuillez entrer votre login';
                            }
                            return null;

                          },
                          // controller: authVm.loginController,
                          labelText: "Login",
                          hintext: "Saisissez votre login",
                          obscureText: false,
                        ),

                        const SizedBox(height: 20),

                        // Mot de passe
                        InputText(
                          // controller: authVm.passwordController,
                          labelText: "Mot de passe",
                          hintext: "Saisissez votre mot de passe",
                          obscureText: _obscureText,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureText
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.grey,
                            ),
                            onPressed: _togglePasswordView,
                          ),
                        ),

                        const SizedBox(height: 8),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                // context.push(AppRouteName.page, extra: const MotDePasseOublieView());
                              },
                              child: Text(
                                'Mot de passe oublié ?',
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  // fontSize: 14,
                                  color: AppColors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Pas encore enrôlé ? ",
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(
                                fontSize: 14,
                                color: Colors.black.withOpacity(0.7),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                // context.push(AppRouteName.inscription);
                              },
                              child: Text(
                                "S'enrôler.",
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(
                                  fontSize: 14,
                                  color: AppColors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),

      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: PrimaryButton(
            title: "Se connecter",
            onPressed: () async {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                 return HomeShellView();
              },));
            },
          ),
        ),
      ),
    );
  }
}
