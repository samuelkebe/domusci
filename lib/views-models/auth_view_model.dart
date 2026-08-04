import 'package:flutter/foundation.dart';
import '../exception/app_exception.dart';
import '../models/user.dart';
import '../utils/view_state.dart';
import '../web-services/auth_service.dart';

/// ViewModel — Authentification (connexion, OTP, mot de passe oublié).
class AuthViewModel extends ChangeNotifier {
  final AuthService _service;
  AuthViewModel({AuthService? service}) : _service = service ?? AuthService();

  ViewState state = ViewState.idle;
  String? errorMessage;
  AppUser? currentUser;

  bool get isLoading => state == ViewState.loading;
  bool get isAuthenticated => currentUser != null;

  Future<bool> login({required String phone, required String password}) async {
    state = ViewState.loading;
    errorMessage = null;
    notifyListeners();
    try {
      currentUser = await _service.login(phone: phone, password: password);
      state = ViewState.loaded;
      notifyListeners();
      return true;
    } on AppException catch (e) {
      errorMessage = e.message;
      state = ViewState.error;
      notifyListeners();
      return false;
    } catch (_) {
      errorMessage = 'Une erreur est survenue, veuillez réessayer.';
      state = ViewState.error;
      notifyListeners();
      return false;
    }
  }

  Future<bool> loginWithGoogle() => _socialLogin(_service.loginWithGoogle);
  Future<bool> loginWithApple() => _socialLogin(_service.loginWithApple);

  Future<bool> _socialLogin(Future<AppUser> Function() action) async {
    state = ViewState.loading;
    notifyListeners();
    try {
      currentUser = await action();
      state = ViewState.loaded;
      notifyListeners();
      return true;
    } on AppException catch (e) {
      errorMessage = e.message;
      state = ViewState.error;
      notifyListeners();
      return false;
    }
  }

  Future<bool> sendOtp(String phone) async {
    try {
      await _service.sendOtp(phone: phone);
      return true;
    } on AppException catch (e) {
      errorMessage = e.message;
      notifyListeners();
      return false;
    }
  }

  Future<bool> verifyOtp({required String phone, required String code}) async {
    try {
      currentUser = await _service.verifyOtp(phone: phone, code: code);
      notifyListeners();
      return true;
    } on AppException catch (e) {
      errorMessage = e.message;
      notifyListeners();
      return false;
    }
  }

  void logout() {
    currentUser = null;
    state = ViewState.idle;
    notifyListeners();
  }
}

