import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../resources/color.dart';
import '../utils/theme_provider.dart';


void showResponsiveBottomSheet(BuildContext context, Widget content) {
  late final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
  late final isDarkMode = themeProvider.isDarkMode;
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    backgroundColor: isDarkMode ? AppColors.black : AppColors.white,
    builder: (context) {
      return LayoutBuilder(
        builder: (context, constraints) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Container(
              color: isDarkMode ? AppColors.black : AppColors.white,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [content],
                  ),
                ),
              ),
            ),
          );
        },
      );
    },
  );
}

