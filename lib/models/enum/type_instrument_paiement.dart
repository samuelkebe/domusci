enum TypeInstrumentPaiement {
  COMPTE_BANCAIRE,
  CARTE_BANCAIRE,
  MOBILE_WALLET;

  static TypeInstrumentPaiement? fromString(String? type) {
    if (type == null) return null;
    switch (type) {
      case 'COMPTE_BANCAIRE':
        return TypeInstrumentPaiement.COMPTE_BANCAIRE;
      case 'CARTE_BANCAIRE':
        return TypeInstrumentPaiement.CARTE_BANCAIRE;
      case 'MOBILE_WALLET':
        return TypeInstrumentPaiement.MOBILE_WALLET;
      default:
        return null;
    }
  }
}