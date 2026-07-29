enum SensMouvement {
  CREDIT,
  DEBIT,
  AUTRE;

  static SensMouvement? fromString(String? sens) {
    if (sens == null) return null;
    switch (sens.toUpperCase()) {
      case "CREDIT":
        return SensMouvement.CREDIT;
      case "DEBIT":
        return SensMouvement.DEBIT;
      case "AUTRE":
        return SensMouvement.AUTRE;
      default:
        return null;
    }
  }
}
