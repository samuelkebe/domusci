import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../resources/color.dart';

class InputCalendrierWidget extends StatelessWidget {
  final String? dateTimeText; // Nullable pour validation
  final VoidCallback? onTap;
  final FormFieldValidator<String>? validator;

  const InputCalendrierWidget({
    super.key,
    required this.dateTimeText,
    this.onTap,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {

    return FormField<String>(
      validator: validator,
      builder: (FormFieldState<String> field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: onTap,
              child: InputDecorator(
                decoration: InputDecoration(
                  hintStyle:  Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.black.withOpacity(0.6),
                  ),
                  labelStyle:  Theme.of(context).textTheme.bodyMedium,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
                  ),

                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      dateTimeText ?? "Sélectionner une date",
                      style:  Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: dateTimeText == null ? AppColors.primaryColor : Colors.black,
                      ),
                    ),
                    const Icon(Icons.calendar_month_outlined, size: 24),
                  ],
                ),
              ),
            ),
            if (field.hasError)
              Padding(
                padding: const EdgeInsets.only(top: 8, left: 8),
                child: Text(
                  field.errorText!,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

