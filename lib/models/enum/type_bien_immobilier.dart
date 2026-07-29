enum TypeBienImmobilier {
  appartement,
  maison,
  villa,
  studio,
  terrain,
  bureau,
  commercial,
  duplex,
  ;

  static TypeBienImmobilier? fromString(String? type) {
    if (type == null) return null;
    switch (type.toLowerCase()) {
      case "appartement":
        return TypeBienImmobilier.appartement;
      case "maison":
        return TypeBienImmobilier.maison;
      case "villa":
        return TypeBienImmobilier.villa;
      case "studio":
        return TypeBienImmobilier.studio;
      case "terrain":
        return TypeBienImmobilier.terrain;
      case "bureau":
        return TypeBienImmobilier.bureau;
      case "commercial":
        return TypeBienImmobilier.commercial;
      case "duplex":
        return TypeBienImmobilier.duplex;
      default:
        return null;
    }
  }

  String get displayName {
    switch (this) {
      case TypeBienImmobilier.appartement:
        return "Appartement";
      case TypeBienImmobilier.maison:
        return "Maison";
      case TypeBienImmobilier.villa:
        return "Villa";
      case TypeBienImmobilier.studio:
        return "Studio";
      case TypeBienImmobilier.terrain:
        return "Terrain";
      case TypeBienImmobilier.bureau:
        return "Bureau";
      case TypeBienImmobilier.commercial:
        return "Commercial";
      case TypeBienImmobilier.duplex:
        return "Duplex";
    }
  }
}
