import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

import '../resources/color.dart';


class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            // HEADER avec avatar et rôle
            Container(
              padding: const EdgeInsets.all(16),
              width: double.infinity,
              decoration: const BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: Colors.white,
                    child: Text(
                      "AF",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Administrateur",
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "af@example.com",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Liste des options
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  ListTile(
                    leading: const Icon(Icons.person, color: AppColors.primaryColor, size: 18),
                    title: Text(
                      "Voir le profil",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 13),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                    onTap: () {
                      // Navigator.pop(context);
                      // context.push(AppRouteName.page, extra: const ProfilView());
                    },
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    // hoverColor: AppColors.lighgrey.withOpacity(0.3),
                  ),

                  const Divider(height: 32, thickness: 1),
                  ListTile(
                    leading: const Icon(Icons.logout, color: Colors.redAccent, size: 18),
                    title: const Text(
                      "Déconnexion",
                      style: TextStyle(color: Colors.redAccent, fontSize: 13),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                    onTap: () {
                      // context.go(AppRouteName.login);
                    },
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    // hoverColor: AppColors.lighgrey.withOpacity(0.3),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}



