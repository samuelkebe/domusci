import '../exception/app_exception.dart';
import '../models/property.dart';
import 'mock/mock_properties.dart';

/// Couche service — simule des appels réseau (à remplacer par de vrais appels
/// HTTP/REST ou GraphQL vers l'API Domus CI en production).
class PropertyService {
  Future<List<Property>> fetchAll({String? query, PropertyType? type, String? quartier}) async {
    await Future.delayed(const Duration(milliseconds: 500));
    try {
      var results = List<Property>.from(MockProperties.all);
      if (type != null) {
        results = results.where((p) => p.type == type).toList();
      }
      if (quartier != null && quartier.isNotEmpty) {
        results = results.where((p) => p.quartier.toLowerCase().contains(quartier.toLowerCase())).toList();
      }
      if (query != null && query.isNotEmpty) {
        results = results
            .where((p) =>
                p.title.toLowerCase().contains(query.toLowerCase()) ||
                p.quartier.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
      return results;
    } catch (_) {
      throw const ServerException('Impossible de charger les annonces pour le moment.');
    }
  }

  Future<Property> fetchById(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    try {
      return MockProperties.all.firstWhere((p) => p.id == id);
    } catch (_) {
      throw const NotFoundException('Ce bien est introuvable ou a été supprimé.');
    }
  }

  Future<List<Property>> fetchRecommended() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return MockProperties.all.take(4).toList();
  }

  Future<List<Property>> fetchFavorites() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return MockProperties.all.where((p) => p.isFavorite).toList();
  }

  Future<List<Property>> fetchMyListings() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return MockProperties.all.take(3).toList();
  }

  Future<bool> toggleFavorite(String propertyId) async {
    await Future.delayed(const Duration(milliseconds: 150));
    final property = MockProperties.all.firstWhere(
      (p) => p.id == propertyId,
      orElse: () => throw const NotFoundException(),
    );
    property.isFavorite = !property.isFavorite;
    return property.isFavorite;
  }

  Future<void> publishListing({
    required String title,
    required PropertyType type,
    required String quartier,
    required String price,
    required String surface,
    required String description,
  }) async {
    await Future.delayed(const Duration(milliseconds: 700));
    if (title.trim().isEmpty || price.trim().isEmpty) {
      throw const ValidationException('Merci de compléter tous les champs obligatoires.');
    }
    // Simule la création côté serveur — en production : POST /listings
  }
}
