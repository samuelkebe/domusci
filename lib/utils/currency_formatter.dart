/// Formatage des montants en Francs CFA.
class CurrencyFormatter {
  CurrencyFormatter._();

  /// Formate un entier en "350 000 FCFA" (espace comme séparateur de milliers).
  static String format(num amount) {
    final str = amount.toInt().toString();
    final buffer = StringBuffer();
    for (int i = 0; i < str.length; i++) {
      final posFromEnd = str.length - i;
      buffer.write(str[i]);
      if (posFromEnd > 1 && posFromEnd % 3 == 1) buffer.write(' ');
    }
    return '${buffer.toString()} FCFA';
  }

  static String formatMonthly(num amount) => '${format(amount)}/mois';
}

