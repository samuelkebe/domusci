import 'package:intl/intl.dart';

import 'app_icons.dart';

final formatter = NumberFormat("#,###", "fr_FR");

String formatAmount(double? amount) {
  return amount == null ? "0 F CFA" : "${formatter.format(amount)} F CFA";
}

/// Masquer les chiffres du pan de carte en laissant les 4 derniers
/// ex. 1234 5678 9012 3456 -> **** **** **** 3456
/// ex. 1234 -> **** **** **** 1234, etc..
String formatCardPan(String? pan) {
  if (pan == null || pan.isEmpty) return "";

  const int panLength = 16;

  // Garde les 4 derniers caractères
  final last4 = pan.length >= 4 ? pan.substring(pan.length - 4) : pan;

  // Calcule la longueur à masquer
  final maskedLength = panLength - last4.length;
  final maskedPart = '*' * maskedLength;

  // Concatène et formate en groupes de 4
  final fullPan = maskedPart + last4;

  final buffer = StringBuffer();
  for (int i = 0; i < fullPan.length; i += 4) {
    if (i > 0) buffer.write(' ');
    final end = (i + 4 < fullPan.length) ? i + 4 : fullPan.length;
    buffer.write(fullPan.substring(i, end));
  }

  return buffer.toString();
}

// String? getIcon(Pays? item) {
//   switch (item?.codeIso) {
//     case 'TGO':
//       return AppIcons.togoTag;
//     case 'CIV':
//       return AppIcons.civTag;
//     case 'SEN':
//       return AppIcons.senegalTag;
//     case 'BEN':
//       return AppIcons.beninTag;
//     case 'BFA':
//       return AppIcons.burkinaTag;
//     case 'NER':
//       return AppIcons.nigerTag;
//     case 'MLI':
//       return AppIcons.maliTag;
//     case 'GNB':
//       return AppIcons.guineeTag;
//     default:
//       return AppIcons.civTag;
//   }
// }

String getFlag(String indicatif) {
  print("Pays indicatif:: $indicatif");
  switch (indicatif) {
    case '228':
      return AppIcons.togoTag;
    case '225':
      return AppIcons.civTag;
    case '221':
      return AppIcons.senegalTag;
    case '229':
      return AppIcons.beninTag;
    case '226':
      return AppIcons.burkinaTag;
    case '227':
      return AppIcons.nigerTag;
    case '223':
      return AppIcons.maliTag;
    case '245':
      return AppIcons.guineeTag;
    default:
      return "";
  }
}

// Future<bool> demanderPermissionCamera() async {
//   var status = await Permission.camera.status;
//
//   if (status.isGranted) {
//     return true;
//   } else if (status.isDenied) {
//     status = await Permission.camera.request();
//     return status.isGranted;
//   } else if (status.isPermanentlyDenied) {
//     // Diriger l'utilisateur vers les paramètres
//     await openAppSettings();
//     return false;
//   }
//
//   return false;
// }

/// Remplace le mot msidn par numéro de téléphone
String replaceMsidn(String? input) {
  if (input == null) return "";

  // Expression régulière pour:
  // - Insensibilité à la casse (caseSensitive: false)
  // - Word boundaries pour éviter les remplacements partiels (\b)
  final regex = RegExp(r'\bmsidn\b', caseSensitive: false);

  return input.replaceAll(regex, 'numéro de téléphone');
}

/// Ajoute [months] mois à [date], en gérant les fins de mois correctement.
/// Exemple: addMonths(DateTime(2024,1,31), 1) -> DateTime(2024,2,29) (si bissextile).
DateTime addMonths(DateTime date, int months) {
  if (months == 0) return date;
  final int newMonthIndex = date.month - 1 + months;
  final int newYear = date.year + (newMonthIndex ~/ 12);
  final int newMonth = (newMonthIndex % 12) + 1;

  // Détermine le dernier jour du mois cible
  final lastDayOfTargetMonth = DateTime(newYear, newMonth + 1, 0).day;
  final day = date.day <= lastDayOfTargetMonth
      ? date.day
      : lastDayOfTargetMonth;

  return DateTime(
    newYear,
    newMonth,
    day,
    date.hour,
    date.minute,
    date.second,
    date.millisecond,
    date.microsecond,
  );
}

/// Ajoute [years] années en utilisant addMonths(12 * years)
DateTime addYears(DateTime date, int years) {
  return addMonths(date, years * 12);
}

String formatToLocalDateTime(DateTime date) {
  return DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'").format(date.toUtc());
}

String formatToLocalDate(DateTime date) {
  return DateFormat("yyyy-MM-dd").format(date.toUtc());
}

// Formate un RIB en version lisible
// Ex: CI6400112265632141785230 → CI64 00112 265632141785 30
String? displayRibFormat(String? rib) {
  if (rib == null) return null;

  // Supprime tous les espaces
  final clean = rib.replaceAll(RegExp(r'\s+'), '');
  // Longueur minimale
  if (clean.length < 8) return rib;
  // Découpage par regex
  final match = RegExp(r'^(.{5})(.{5})(.+)(.{2})$').firstMatch(clean);
  if (match == null) return rib;

  // (.{4})       → groupe 1 : 4 caractères
  // (.{5})       → groupe 2 : 5 caractères
  // (.+)         → groupe 3 : tout le reste (au moins 1)
  // (.{2})       → groupe 4 : 2 caractères
  // $
  // Reconstruction formatée
  return '${match.group(1)} '
      '${match.group(2)} '
      '${match.group(3)} '
      '${match.group(4)}';
}

// * ^                         # début de chaîne
//    (?=.*[a-z])               # au moins 1 minuscule
//    (?=.*[A-Z])               # au moins 1 majuscule
//    (?=.*\d)                  # au moins 1 chiffre
//    (?=.*[@$!%*?&.#_+-])      # au moins 1 caractère spécial
//    [A-Za-z\d@$!%*?&.#_+-]    # caractères autorisés
//    {8,}                      # longueur minimale = 8
//    $                         # fin de chaîne

Future<bool> isValidPassword(String? pw) async {
  if (pw == null) return false;
  final passwordRegExp = RegExp(
    r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&.#_+-])[A-Za-z\d@$!%*?&.#_+-]{8,}$',
  );

  return passwordRegExp.hasMatch(pw);
}

String? validatePassword(String? pw) {
  if (pw == null || pw.isEmpty) return 'Mot de passe requis';
  if (pw.length < 8) return 'Au moins 8 caractères';
  if (!RegExp(r'[A-Z]').hasMatch(pw)) return 'Une majuscule requise';
  if (!RegExp(r'[a-z]').hasMatch(pw)) return 'Une minuscule requise';
  if (!RegExp(r'\d').hasMatch(pw)) return 'Un chiffre requis';
  if (!RegExp(r'[@$!%*?&.#_+-]').hasMatch(pw)) {
    return 'Un caractère spécial requis';
  }
  return null;
}

String getCompteNumberFromRib(String? rib) {
  if (rib == null || rib.length < 12) return "";

  return rib.substring(10, rib.length - 2);
}


extension DateFormatExt on DateTime {
  String toYyyyMmDd() =>
      '${year.toString().padLeft(4, '0')}-'
          '${month.toString().padLeft(2, '0')}-'
          '${day.toString().padLeft(2, '0')}';
}
