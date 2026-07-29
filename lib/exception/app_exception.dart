/// Exception de base de l'application — toutes les exceptions métier en héritent.
abstract class AppException implements Exception {
  final String message;
  const AppException(this.message);

  @override
  String toString() => message;
}

/// Erreur réseau (timeout, pas de connexion, serveur injoignable…).
class NetworkException extends AppException {
  const NetworkException([super.message = 'Vérifiez votre connexion internet et réessayez.']);
}

/// Erreur d'authentification (identifiants invalides, session expirée…).
class AuthException extends AppException {
  const AuthException([super.message = 'Numéro ou mot de passe incorrect.']);
}

/// Erreur de validation de formulaire (champ manquant, format invalide…).
class ValidationException extends AppException {
  const ValidationException(super.message);
}

/// Ressource introuvable (bien, conversation, annonce…).
class NotFoundException extends AppException {
  const NotFoundException([super.message = 'Cet élément est introuvable ou a été supprimé.']);
}

/// Erreur générique de serveur / service.
class ServerException extends AppException {
  const ServerException([super.message = 'Une erreur est survenue, veuillez réessayer.']);
}
