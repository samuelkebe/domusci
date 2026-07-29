import 'package:domusci/components/primary_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GarderLeControle extends StatelessWidget {
  const GarderLeControle({super.key});

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // --- Image centrée ---
            Center(
              child: Image.asset(
                'assets/images/Profile.png',
                width: 109,
                height: 107,
              ),
            ),
            const SizedBox(height: 24),

            Text(
              'Gardez le contrôle',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            // --- Description ---
            Text(
              'Inscrivez-vous en tant que marchand et profitez d’un espace de gestion complet de vos boutiques.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 15,
              ),
            ),

            const SizedBox(height: 32),

            // --- Bouton ---
            PrimaryButton(
              title: "Continuer",
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
