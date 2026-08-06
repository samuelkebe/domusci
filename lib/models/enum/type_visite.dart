enum TypeVisite {
  SUR_SITE('VISITE SUR SITE'),
  VIRTUELLE('VISITE VIRTUELLE');

  final String label;

  const TypeVisite(this.label);

  static TypeVisite? fromString(String value) {
    for (var type in TypeVisite.values) {
      if (type.label == value) return type;
    }
    return null;
  }
}
