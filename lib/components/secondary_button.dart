import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../resources/color.dart';
import '../utils/theme_provider.dart';

class SecondaryButton extends StatelessWidget {
  SecondaryButton({super.key, required this.title, this.onPressed});
  final String title;
  Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // Récupère le thème du projet
    late final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    late final isDarkMode = themeProvider.isDarkMode;

    return FilledButton(
      // style: ButtonStyle(
      //   // textStyle: WidgetStatePropertyAll(Theme.of(context).textTheme.bodyMedium),
      //   // foregroundColor: WidgetStatePropertyAll(AppColors.white),
      //   // backgroundColor: WidgetStatePropertyAll(AppColors.primary),
      // ),
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: isDarkMode ? AppColors.black : AppColors.white,

        foregroundColor: AppColors.secondaryColor,
        minimumSize: const Size(double.infinity, 48),
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          side: BorderSide(color: isDarkMode ? AppColors.white : AppColors.secondaryColor, width: 2),

        ),
      ),
      onPressed:onPressed,
      child:  Text(title,

        style: theme.textTheme.titleLarge?.copyWith(
            fontSize: 16,
            color: isDarkMode ? AppColors.white : AppColors.secondaryColor
        ),
      ),
    );
  }
}
