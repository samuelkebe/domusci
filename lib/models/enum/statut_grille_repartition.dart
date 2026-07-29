enum StatutGrilleRepartition {
  ACTIF,
  INACTIF,
  ;

  static StatutGrilleRepartition? fromString(String? statut) {
    if (statut == null) return null;
    switch (statut.toUpperCase()) {
      case "ACTIF":
        return StatutGrilleRepartition.ACTIF;
      case "INACTIF":
        return StatutGrilleRepartition.INACTIF;

      default:
        return null;
    }
  }
}