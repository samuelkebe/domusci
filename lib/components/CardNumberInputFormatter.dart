import 'package:flutter/services.dart';

class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    // Supprime tous les espaces
    String digitsOnly = newValue.text.replaceAll(' ', '');

    // Limite à 16 chiffres
    if (digitsOnly.length > 16) {
      digitsOnly = digitsOnly.substring(0, 16);
    }

    // Ajoute un espace tous les 4 chiffres
    String formatted = '';
    for (int i = 0; i < digitsOnly.length; i++) {
      if (i != 0 && i % 4 == 0) {
        formatted += ' ';
      }
      formatted += digitsOnly[i];
    }

    // Maintient la position du curseur
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
