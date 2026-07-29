enum CategorieProduit {
  ALIMENTAIRE,
  ACCESSOIRE,
  QUINCALLERIE,
  AUTOMOBILE;

  static CategorieProduit? fromString(String? categorie) {
    if (categorie == null) return null;
    switch (categorie.toUpperCase()) {
      case "ALIMENTAIRE":
        return CategorieProduit.ALIMENTAIRE;
      case "ACCESSOIRE":
        return CategorieProduit.ACCESSOIRE;
        case "QUINCALLERIE":
        return CategorieProduit.QUINCALLERIE;
        case "AUTOMOBILE":
        return CategorieProduit.AUTOMOBILE;

      default:
        return null;
    }
  }
}