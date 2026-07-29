import 'package:domusci/models/bien_immobilier_model.dart';
import 'package:flutter/foundation.dart';
import '../exception/app_exception.dart';
import '../models/enum/statut_bien_immobilier.dart';
import '../models/enum/type_bien_immobilier.dart';
import '../models/property.dart';
import '../utils/view_state.dart';

/// ViewModel — Écran d'Accueil (catégories, quartiers, biens recommandés).
class HomeViewModel extends ChangeNotifier {

  BienImmobilier? selectedBienImmobilier;
  bool isLoadingBienImmobiliers = false;

  void setSelectedBienImmobilier(BienImmobilier bienImmobilier) {
    selectedBienImmobilier = bienImmobilier;
    notifyListeners();
  }

  List<BienImmobilier> bienImmobiliers = [];
  List<BienImmobilier> filteredBienImmobiliers = [];
  String searchQuery = '';

  void updateSearchQueryBiensImmobiliers(String query) {
    searchQuery = query;

    if (query.isEmpty) {
      filteredBienImmobiliers = bienImmobiliers;
    } else {
      filteredBienImmobiliers = bienImmobiliers.where((bien) {
        final fullName = "${bien.titre} " "${bien.adresse}".toLowerCase();
        return fullName.contains(query.toLowerCase());
      }).toList();
    }

    notifyListeners();
  }

  Future<void> getBienImmobiliers() async{
    bienImmobiliers = [
      BienImmobilier(
        adresse: "COCODY",
        titre: "VILLA COCODY",
        prix: 350000000,
        imageUrl: "https://images.unsplash.com/photo-1570129477492-45c003edd2be?auto=format&fit=crop&w=800&q=80",
        chambres: "3",
        sallesDeBain: "2",
        parking: 1,
        typeBien: TypeBienImmobilier.appartement,
        statut: StatutBienImmobilier.DISPONIBLE,
      ),
      BienImmobilier(
        adresse: "COCODY",
        titre: "VILLA COCODY",
        prix: 350000000,
        imageUrl: "https://images.unsplash.com/photo-1570129477492-45c003edd2be?auto=format&fit=crop&w=800&q=80",
        chambres: "3",
        sallesDeBain: "2",
        parking: 1,
        typeBien: TypeBienImmobilier.appartement,
        statut: StatutBienImmobilier.DISPONIBLE,
      ),

    ];
    filteredBienImmobiliers = bienImmobiliers;
    notifyListeners();
  }


}
