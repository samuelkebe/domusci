enum StatutBienImmobilier {
  disponible,
  vendu,
  loue,
  en_attente,
  reserve,
  ;

  static StatutBienImmobilier? fromString(String? statut) {
    if (statut == null) return null;
    switch (statut.toLowerCase()) {
      case "disponible":
        return StatutBienImmobilier.disponible;
      case "vendu":
        return StatutBienImmobilier.vendu;
      case "loue":
        return StatutBienImmobilier.loue;
      case "en_attente":
        return StatutBienImmobilier.en_attente;
      case "reserve":
        return StatutBienImmobilier.reserve;
      default:
        return null;
    }
  }

  String get displayName {
    switch (this) {
      case StatutBienImmobilier.disponible:
        return "Disponible";
      case StatutBienImmobilier.vendu:
        return "Vendu";
      case StatutBienImmobilier.loue:
        return "Loué";
      case StatutBienImmobilier.en_attente:
        return "En attente";
      case StatutBienImmobilier.reserve:
        return "Réservé";
    }
  }
}
