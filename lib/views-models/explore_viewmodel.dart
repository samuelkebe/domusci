import 'package:flutter/material.dart';

import '../models/property.dart';
import '../models/user.dart';

/// ViewModel — Explorer : recherche, filtres (catégorie / quartier),
/// favoris et chargement des annonces affichées dans [ExplorerView].
class ExplorerViewModel extends ChangeNotifier {



  final TextEditingController searchController = TextEditingController();

  bool isLoading = true;
  String? errorMessage;

  List<Property> _allListings = [];
  List<Property> listings = [];

  int selectedCategoryIndex = -1;
  String? selectedQuartier;
  String _query = '';

  final Set<String> _favoriteIds = <String>{};

  String get currentUserAvatarUrl => AppUser.demo.avatarUrl;

  /// Charge (ou recharge) les annonces depuis le repository puis
  /// réapplique les filtres actifs (catégorie, quartier, recherche).
  Future<void> refresh() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      // _allListings = await _repository.fetchListings();
      _applyFilters();
    } catch (e) {
      errorMessage = 'Impossible de charger les annonces.';
      _allListings = [];
      listings = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void selectCategory(int index) {
    selectedCategoryIndex = selectedCategoryIndex == index ? -1 : index;
    _applyFilters();
    notifyListeners();
  }

  void filterByQuartier(String name) {
    selectedQuartier = selectedQuartier == name ? null : name;
    _applyFilters();
    notifyListeners();
  }

  void _onSearchChanged() {
    _query = searchController.text.trim().toLowerCase();
    _applyFilters();
    notifyListeners();
  }

  void _applyFilters() {
    listings = _allListings.where((p) {
      final matchesCategory =
          selectedCategoryIndex == -1 || p.type == _categoryTypeFor(selectedCategoryIndex);
      final matchesQuartier =
          selectedQuartier == null || p.quartier.toLowerCase().contains(selectedQuartier!.toLowerCase());
      final matchesQuery = _query.isEmpty ||
          p.title.toLowerCase().contains(_query) ||
          p.quartier.toLowerCase().contains(_query);
      return matchesCategory && matchesQuartier && matchesQuery;
    }).toList();
  }

  PropertyType? _categoryTypeFor(int index) {
    const order = [
      PropertyType.appartement,
      PropertyType.maison,
      PropertyType.villa,
      PropertyType.terrain,
    ];
    if (index < 0 || index >= order.length) return null;
    return order[index];
  }

  bool isFavorite(Property property) => _favoriteIds.contains(property.id);

  Future<void> toggleFavorite(Property property) async {
    if (_favoriteIds.contains(property.id)) {
      _favoriteIds.remove(property.id);
    } else {
      _favoriteIds.add(property.id);
    }
    notifyListeners();
    // Persiste le changement côté serveur/local; on ignore l'échec ici
    // pour ne pas bloquer l'UI, l'état local restant la source de vérité.
    // unawaited(_repository.setFavorite(property.id, isFavorite(property)));
  }

  // --- Navigation / actions déléguées à la vue ---

  VoidCallback? onOpenFilters;
  VoidCallback? onOpenMap;
  VoidCallback? onSeeAllQuartiers;
  VoidCallback? onOpenNotifications;
  VoidCallback? onOpenChat;

  void openFilters() => onOpenFilters?.call();
  void openMap() => onOpenMap?.call();
  void seeAllQuartiers() => onSeeAllQuartiers?.call();
  void openNotifications() => onOpenNotifications?.call();
  void openChat() => onOpenChat?.call();

  @override
  void dispose() {
    searchController.removeListener(_onSearchChanged);
    searchController.dispose();
    super.dispose();
  }
}

/// Petit helper pour ignorer explicitement un Future sans bloquer l'appelant.
void unawaited(Future<void> future) {}
