import 'package:flutter/foundation.dart';
import '../exception/app_exception.dart';
import '../models/property.dart';
import '../utils/view_state.dart';
import '../web-services/property_service.dart';

/// ViewModel — Favoris.
class FavoritesViewModel extends ChangeNotifier {
  final PropertyService _service;
  FavoritesViewModel({PropertyService? service}) : _service = service ?? PropertyService();

  ViewState state = ViewState.idle;
  String? errorMessage;
  List<Property> favorites = [];

  bool get isLoading => state == ViewState.loading;
  bool get isEmpty => state == ViewState.loaded && favorites.isEmpty;

  Future<void> load() async {
    state = ViewState.loading;
    notifyListeners();
    try {
      favorites = await _service.fetchFavorites();
      state = ViewState.loaded;
    } on AppException catch (e) {
      errorMessage = e.message;
      state = ViewState.error;
    }
    notifyListeners();
  }

  Future<void> remove(Property property) async {
    favorites.removeWhere((p) => p.id == property.id);
    notifyListeners();
    try {
      await _service.toggleFavorite(property.id);
    } catch (_) {
      await load();
    }
  }
}
