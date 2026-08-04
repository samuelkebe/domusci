enum StatutTransaction {
  INITIEE,
  EN_COURS,
  SUCCESS,
  ECHOUEE,
  EXTOURNEE;

  static StatutTransaction? fromString(String? statut) {
  if (statut == null) return null;
  switch (statut) {
    case 'INITIEE':
      return StatutTransaction.INITIEE;
    case 'EN_COURS':
      return StatutTransaction.EN_COURS;
    case 'SUCCESS':
      return StatutTransaction.SUCCESS;
    case 'ECHOUEE':
      return StatutTransaction.ECHOUEE;
    case 'EXTOURNEE':
      return StatutTransaction.EXTOURNEE;
    default:
      return null;
  }
}
}




