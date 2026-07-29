import '../exception/app_exception.dart';
import '../models/user.dart';
import '../utils/validators.dart';

/// Service d'authentification — connexion, inscription, OTP.
/// En production : appels vers Firebase Auth / API Domus CI + fournisseurs OAuth.
class AuthService {
  Future<AppUser> login({required String phone, required String password}) async {
    Validators.validateIvorianPhone(phone);
    Validators.validatePassword(password);
    await Future.delayed(const Duration(milliseconds: 800));
    // Démo : toute combinaison valide connecte l'utilisateur démo.
    return AppUser.demo;
  }

  Future<void> sendOtp({required String phone}) async {
    Validators.validateIvorianPhone(phone);
    await Future.delayed(const Duration(milliseconds: 600));
  }

  Future<AppUser> verifyOtp({required String phone, required String code}) async {
    await Future.delayed(const Duration(milliseconds: 600));
    if (code.length != 4) {
      throw const AuthException('Code de vérification invalide.');
    }
    return AppUser.demo;
  }

  Future<AppUser> loginWithGoogle() async {
    await Future.delayed(const Duration(milliseconds: 900));
    return AppUser.demo;
  }

  Future<AppUser> loginWithApple() async {
    await Future.delayed(const Duration(milliseconds: 900));
    return AppUser.demo;
  }

  Future<void> requestPasswordReset({required String phone}) async {
    Validators.validateIvorianPhone(phone);
    await Future.delayed(const Duration(milliseconds: 600));
  }
}
