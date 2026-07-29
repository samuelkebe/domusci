enum StatutBienImmobilier {
  DISPONIBLE,
  VENDU,
  LOUE,
  RESERVE,
  ;

  static StatutBienImmobilier? fromString(String? statut) {
    if (statut == null) return null;
    switch (statut.toLowerCase()) {
      case "DISPONIBLE":
        return StatutBienImmobilier.DISPONIBLE;
      case "VENDU":
        return StatutBienImmobilier.VENDU;
      case "LOUE":
        return StatutBienImmobilier.LOUE;
    
      case "RESERVE":
        return StatutBienImmobilier.RESERVE;
      default:
        return null;
    }
  }

  String get displayName {
    switch (this) {
      case StatutBienImmobilier.DISPONIBLE:
        return "DISPONIBLE";
      case StatutBienImmobilier.VENDU:
        return "VENDU";
      case StatutBienImmobilier.LOUE:
        return "LOUE";
      case StatutBienImmobilier.RESERVE:
        return "Réservé";
    }
  }
}
