import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../resources/color.dart';

class TertiaryButton extends StatelessWidget {

  TertiaryButton({super.key, required this.title, this.onPressed});

  final String title;
  Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // Récupère le thème du projet

    return FilledButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor:  Colors.red,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 48),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
      ),
      onPressed:onPressed,
      child:  Text(title,

        style: theme.textTheme.titleLarge?.copyWith(
          fontSize: 16,
          color: Colors.white,
        ),
      ),
    );
  }
}

