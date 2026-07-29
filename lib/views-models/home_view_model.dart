import 'package:flutter/foundation.dart';
import '../exception/app_exception.dart';
import '../models/property.dart';
import '../utils/view_state.dart';
import '../web-services/mock/mock_properties.dart';
import '../web-services/property_service.dart';

/// ViewModel — Écran d'Accueil (catégories, quartiers, biens recommandés).
class HomeViewModel extends ChangeNotifier {
  final PropertyService _service;
  HomeViewModel({PropertyService? service}) : _service = service ?? PropertyService();

  ViewState state = ViewState.idle;
  String? errorMessage;
  List<Property> recommended = [];
  int selectedCategoryIndex = 0;

  List<String> get quartiers => MockProperties.quartiers;

  bool get isLoading => state == ViewState.loading;

  Future<void> loadHome() async {
    state = ViewState.loading;
    notifyListeners();
    try {
      recommended = await _service.fetchRecommended();
      state = ViewState.loaded;
    } on AppException catch (e) {
      errorMessage = e.message;
      state = ViewState.error;
    } catch (_) {
      errorMessage = 'Impossible de charger les biens recommandés.';
      state = ViewState.error;
    }
    notifyListeners();
  }

  Future<void> refresh() => loadHome();

  void selectCategory(int index) {
    selectedCategoryIndex = index;
    notifyListeners();
  }

  Future<void> toggleFavorite(Property property) async {
    property.isFavorite = !property.isFavorite;
    notifyListeners();
    try {
      await _service.toggleFavorite(property.id);
    } catch (_) {
      // rollback en cas d'échec réseau
      property.isFavorite = !property.isFavorite;
      notifyListeners();
    }
  }
}
