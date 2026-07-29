enum StatutNotification {
  LUE,
  NON_LUE;

  static StatutNotification? fromString(String? statut) {
    if (statut == null) return null;
    switch (statut.toUpperCase()) {
      case "LUE":
        return StatutNotification.LUE;
      case "NON_LUE":
        return StatutNotification.NON_LUE;
      default:
        return null;
    }
  }
}
