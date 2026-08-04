enum StatutInstrumentPaiement {
  ACTIF,
  INACTIF;

  static StatutInstrumentPaiement? fromString(String? type) {
    if (type == null) return null;
    switch (type) {
      case 'ACTIF':
        return StatutInstrumentPaiement.ACTIF;
      case 'INACTIF':
        return StatutInstrumentPaiement.INACTIF;

      default:
        return null;
    }
  }
}
