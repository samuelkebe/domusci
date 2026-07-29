import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../resources/color.dart';
import '../utils/langue_provider.dart';
import '../utils/theme_provider.dart';

void showMonthBottomSheet({
  required BuildContext context,
  required int selectedMonth,
  required int currentMonth,
  required Function(int) onMonthSelected,
}) {
  final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
  final isDarkMode = themeProvider.isDarkMode;

  final langueProvider = Provider.of<LanguageProvider>(context, listen: false);
  final isFrench = langueProvider.locale.languageCode == 'fr';

  final List<String> monthsFr = [
    "Janvier","Février","Mars","Avril","Mai","Juin",
    "Juillet","Août","Septembre","Octobre","Novembre","Décembre"
  ];

  final List<String> monthsEn = [
    "January","February","March","April","May","June",
    "July","August","September","October","November","December"
  ];

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    backgroundColor: isDarkMode ? AppColors.black2 : Colors.white,
    builder: (context) {
      return SafeArea(
        child: FractionallySizedBox(
          heightFactor: 0.6,
          child: Column(
            children: [
              const SizedBox(height: 12),
              Text(
                isFrench
                    ? "Sélectionnez un mois"
                    : "Select a month",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),

              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: 12,
                  itemBuilder: (context, index) {
                    final monthNumber = index + 1;
                    final isSelected = monthNumber == selectedMonth;
                    final isCurrent = monthNumber == currentMonth;

                    final monthName =
                    isFrench ? monthsFr[index] : monthsEn[index];

                    return Card(
                      color: isSelected
                          ? AppColors.primaryColor.withOpacity(0.15)
                          : (isDarkMode
                          ? AppColors.black
                          : Colors.grey.shade100),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: BorderSide(
                          color: isSelected
                              ? AppColors.primaryColor
                              : (isDarkMode
                              ? Colors.grey.shade700
                              : Colors.grey.shade300),
                        ),
                      ),
                      child: ListTile(
                        title: Text(
                          isCurrent
                              ? "${isFrench ? "Ce mois" : "This month"} - $monthName"
                              : monthName,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        trailing: isSelected
                            ? Icon(
                          Icons.check_circle,
                          color: AppColors.primaryColor,
                        )
                            : null,
                        onTap: () {
                          onMonthSelected(monthNumber);
                          Navigator.pop(context);
                        },
                      ),
                    );
                  },
                  separatorBuilder: (_, __) =>
                  const SizedBox(height: 8),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}