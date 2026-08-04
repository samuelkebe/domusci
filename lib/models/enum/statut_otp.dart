enum StatutOtp {
  INITIE, UTILISE, ACTIVE, DESACTIVE;


  static StatutOtp? fromString(String? statut) {
    if (statut == null) return null;
    switch (statut.toUpperCase()) {
      case "INITIE":
        return StatutOtp.INITIE;
      case "UTILISE":
        return StatutOtp.UTILISE; 
        case "ACTIVE":
        return StatutOtp.ACTIVE;
        case "DESACTIVE":
        return StatutOtp.DESACTIVE;
        case "INACTIF":

      default:
        return null;
    }
  }
}
