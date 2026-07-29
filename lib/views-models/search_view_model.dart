import 'package:flutter/foundation.dart';
import '../exception/app_exception.dart';
import '../models/property.dart';
import '../utils/view_state.dart';
import '../web-services/property_service.dart';

enum SearchDisplayMode { list, map }

/// ViewModel — Recherche (filtres, vue liste/carte).
class SearchViewModel extends ChangeNotifier {
  final PropertyService _service;
  SearchViewModel({PropertyService? service}) : _service = service ?? PropertyService();

  ViewState state = ViewState.idle;
  String? errorMessage;
  List<Property> results = [];
  PropertyType? typeFilter;
  String query = '';
  SearchDisplayMode displayMode = SearchDisplayMode.list;

  bool get isLoading => state == ViewState.loading;

  Future<void> search() async {
    state = ViewState.loading;
    notifyListeners();
    try {
      results = await _service.fetchAll(query: query, type: typeFilter);
      state = ViewState.loaded;
    } on AppException catch (e) {
      errorMessage = e.message;
      state = ViewState.error;
    }
    notifyListeners();
  }

  void setQuery(String value) {
    query = value;
    search();
  }

  void setTypeFilter(PropertyType? type) {
    typeFilter = type;
    search();
  }

  void setDisplayMode(SearchDisplayMode mode) {
    displayMode = mode;
    notifyListeners();
  }

  Future<void> toggleFavorite(Property property) async {
    property.isFavorite = !property.isFavorite;
    notifyListeners();
    try {
      await _service.toggleFavorite(property.id);
    } catch (_) {
      property.isFavorite = !property.isFavorite;
      notifyListeners();
    }
  }
}
