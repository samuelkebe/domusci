import 'package:flutter/foundation.dart';
import '../exception/app_exception.dart';
import '../models/property.dart';
import '../utils/view_state.dart';
import '../web-services/property_service.dart';

/// ViewModel — Mes annonces (gestion des biens publiés par l'utilisateur).
class ListingsViewModel extends ChangeNotifier {
  final PropertyService _service;
  ListingsViewModel({PropertyService? service}) : _service = service ?? PropertyService();

  ViewState state = ViewState.idle;
  String? errorMessage;
  List<Property> listings = [];

  bool get isLoading => state == ViewState.loading;

  Future<void> load() async {
    state = ViewState.loading;
    notifyListeners();
    try {
      listings = await _service.fetchMyListings();
      state = ViewState.loaded;
    } on AppException catch (e) {
      errorMessage = e.message;
      state = ViewState.error;
    }
    notifyListeners();
  }

  Future<void> renew(Property property) async {
    // Simule le renouvellement d'une annonce.
    notifyListeners();
  }

  Future<void> remove(Property property) async {
    listings.removeWhere((p) => p.id == property.id);
    notifyListeners();
  }
}
