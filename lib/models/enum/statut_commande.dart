enum StatutCommande {
  LIVRE_EN_ATTENTE_DE_PAIEMENT,
  EN_COURS,
  LIVRE_ET_PAYE,
  EN_ATTENTE_DE_LIVRAISON,
  ANNULEE,
  RETOUR_DE_MARCHANDISES;

  static StatutCommande? fromString(String? statut) {
    if (statut == null) return null;
    switch (statut.toUpperCase()) {
      case "LIVRE EN ATTENTE DE PAIEMENT":
        return StatutCommande.LIVRE_EN_ATTENTE_DE_PAIEMENT;
      case "EN COURS":
        return StatutCommande.EN_COURS;
      case "LIVRE ET PAYE":
        return StatutCommande.LIVRE_ET_PAYE;
        case "EN ATTENTE DE LIVRAISON":
        return StatutCommande.EN_ATTENTE_DE_LIVRAISON;
        case "ANNULEE":
        return StatutCommande.ANNULEE;
        case "RETOUR DE MARCHANDISES":
        return StatutCommande.RETOUR_DE_MARCHANDISES;


      default:
        return null;
    }
  }
}
