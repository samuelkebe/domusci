enum TypeNotification {
  SYSTEME,
  UTILISATEUR;

  static TypeNotification? fromString(String? type) {
    if (type == null) return null;
    switch (type.toUpperCase()) {
      case "SYSTEME":
        return TypeNotification.SYSTEME;
      case "UTILISATEUR":
        return TypeNotification.UTILISATEUR;

      default:
        return null;
    }
  }
}
