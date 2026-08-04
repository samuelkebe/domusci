enum TypeCarteBancaire {
  CREDIT,
  DEBIT,
  PREPAYE;

  static TypeCarteBancaire? fromString(String? type) {
    if (type == null) return null;
    switch (type) {
      case 'CREDIT':
        return TypeCarteBancaire.CREDIT;
      case 'DEBIT':
        return TypeCarteBancaire.DEBIT;
      case 'PREPAYE':
        return TypeCarteBancaire.PREPAYE;
      default:
        return null;
    }
  }
}
