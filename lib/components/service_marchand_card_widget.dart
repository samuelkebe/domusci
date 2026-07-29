import 'package:flutter/material.dart';

import '../resources/color.dart';



class ServiceMarchandCardWidget extends StatelessWidget {
  const ServiceMarchandCardWidget({
    super.key,
    required this.icon,
    required this.title,
    this.onPressed,
  });

  final Widget icon;
  final String title;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 110,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(

          color:AppColors.lighgrey,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icône
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color:AppColors.lighgrey2,
                shape: BoxShape.circle,
              ),
              child: Center(child: icon),
            ),

            const SizedBox(height: 16),

            // Libellé
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.black,
              ),
            ),

            const SizedBox(height: 4),

            // Montant

          ],
        ),
      ),
    );
  }
}
