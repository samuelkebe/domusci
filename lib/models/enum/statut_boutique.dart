enum StatutBoutique {
  ACTIF,
  INACTIF,
;

  static StatutBoutique? fromString(String? statut) {
    if (statut == null) return null;
    switch (statut.toUpperCase()) {
      case "ACTIF":
        return StatutBoutique.ACTIF;
      case "INACTIF":
        return StatutBoutique.INACTIF;

      default:
        return null;
    }
  }
}
