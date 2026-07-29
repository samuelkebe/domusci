enum StatutLivreur {
  ACTIF,
  INACTIF,
  ;

  static StatutLivreur? fromString(String? statut) {
    if (statut == null) return null;
    switch (statut.toUpperCase()) {
      case "ACTIF":
        return StatutLivreur.ACTIF;
      case "INACTIF":
        return StatutLivreur.INACTIF;

      default:
        return null;
    }
  }
}