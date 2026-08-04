enum TypeCompteBancaire {
  COURANT,
  EPARGNE,
  INTERNE;


  static TypeCompteBancaire? fromString(String? type) {
    if (type == null) return null;
    switch (type) {
      case 'COURANT':
        return TypeCompteBancaire.COURANT;
      case 'EPARGNE':
        return TypeCompteBancaire.EPARGNE;
      case 'INTERNE':
        return TypeCompteBancaire.INTERNE;
      default:
        return null;
    }
  }
}
