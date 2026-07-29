import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../resources/color.dart';

class PrimaryButton extends StatelessWidget {

  PrimaryButton({super.key, required this.title, this.onPressed});

  final String title;
  Function()? onPressed;
  @override
  Widget build(BuildContext context) {

    return FilledButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor:  AppColors.primaryColor,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 48),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
      ),
      onPressed:onPressed,
      child:  Text(title,

        style: Theme.of(context).textTheme.titleLarge?.copyWith(
        fontSize: 16,
        color: Colors.white,
        ),
      ),
    );
  }
}
