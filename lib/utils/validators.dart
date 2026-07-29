import '../exception/app_exception.dart';

/// Validateurs de formulaire — téléphone, mot de passe, champs requis.
class Validators {
  Validators._();

  static final _ivorianPhoneReg = RegExp(r'^(0[1257])[0-9]{8}$');

  static void validateIvorianPhone(String value) {
    final cleaned = value.replaceAll(RegExp(r'[\s\-]'), '');
    if (cleaned.isEmpty) {
      throw const ValidationException('Le numéro de téléphone est requis.');
    }
    if (!_ivorianPhoneReg.hasMatch(cleaned)) {
      throw const ValidationException('Numéro ivoirien invalide (ex : 07 12 34 56 78).');
    }
  }

  static void validatePassword(String value) {
    if (value.isEmpty) {
      throw const ValidationException('Le mot de passe est requis.');
    }
    if (value.length < 6) {
      throw const ValidationException('Le mot de passe doit contenir au moins 6 caractères.');
    }
  }

  static void validateRequired(String value, String fieldLabel) {
    if (value.trim().isEmpty) {
      throw ValidationException('$fieldLabel est requis.');
    }
  }

  static void validatePrice(String value) {
    final cleaned = value.replaceAll(RegExp(r'[\s]'), '');
    if (cleaned.isEmpty || int.tryParse(cleaned) == null) {
      throw const ValidationException('Veuillez saisir un prix valide.');
    }
  }
}
