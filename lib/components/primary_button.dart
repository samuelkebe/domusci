import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../resources/color.dart';
import '../utils/theme_provider.dart';

class PrimaryButton extends StatelessWidget {

  PrimaryButton({super.key, required this.title, this.onPressed});

  final String title;
  Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // Récupère le thème du projet
    late final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    late final isDarkMode = themeProvider.isDarkMode;

    return FilledButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor:  AppColors.green,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 48),
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          side: BorderSide(color: isDarkMode ? AppColors.white : AppColors.black, width: 2),

        ),
      ),
      onPressed:onPressed,
      child:  Text(title,

        style: Theme.of(context).textTheme.titleLarge?.copyWith(
        fontSize: 16,
        color: Colors.black,
        ),
      ),
    );
  }
}
