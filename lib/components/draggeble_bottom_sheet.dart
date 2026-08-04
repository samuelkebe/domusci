import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../resources/color.dart';
import '../utils/theme_provider.dart';

void showResponsiveDraggableBottomSheet(BuildContext context, Widget content, {double? initialChildSize,}) {
  late final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
  late final isDarkMode = themeProvider.isDarkMode;
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    backgroundColor: isDarkMode ? AppColors.black2 : AppColors.white,
    builder: (context) {
      return DraggableScrollableSheet(
        expand: false,
        initialChildSize: initialChildSize ?? 0.3,
        minChildSize: 0.2,
        maxChildSize: 0.9,
        builder: (context, scrollController) {
          return Container(
            color: isDarkMode ? AppColors.black2 : AppColors.white,
            child: SingleChildScrollView(
              controller: scrollController,
              // Lien avec le défilement du contenu
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: content,
              ),
            ),
          );
        },
      );
    },
  );
}

