import 'package:flutter/foundation.dart';
import '../exception/app_exception.dart';
import '../models/property.dart';
import '../utils/view_state.dart';

/// ViewModel — Détail d'un bien immobilier.
class PropertyDetailViewModel extends ChangeNotifier {

  ViewState state = ViewState.idle;
  String? errorMessage;
  Property? property;
  int currentImageIndex = 0;

  bool get isLoading => state == ViewState.loading;

  Future<void> load(String id) async {
    state = ViewState.loading;
    notifyListeners();
    try {
      // property = await _service.fetchById(id);
      state = ViewState.loaded;
    } on AppException catch (e) {
      errorMessage = e.message;
      state = ViewState.error;
    }
    notifyListeners();
  }

  void setImageIndex(int index) {
    currentImageIndex = index;
    notifyListeners();
  }

  Future<void> toggleFavorite() async {
    final p = property;
    if (p == null) return;
    p.isFavorite = !p.isFavorite;
    notifyListeners();
    try {
      // await _service.toggleFavorite(p.id);
    } catch (_) {
      p.isFavorite = !p.isFavorite;
      notifyListeners();
    }
  }
}
