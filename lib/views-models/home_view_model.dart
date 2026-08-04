import 'dart:io';

import 'package:pisso/models/bien_immobilier_model.dart';
import 'package:flutter/foundation.dart';
import '../exception/app_exception.dart';
import '../models/enum/statut_bien_immobilier.dart';
import '../models/property.dart';
import '../models/type_bien.dart';
import '../utils/log_config.dart';
import '../utils/view_state.dart';

/// ViewModel — Écran d'Accueil (catégories, quartiers, biens recommandés).
class HomeViewModel extends ChangeNotifier {
  BienImmobilier? selectedBienImmobilier;
  TypeBienImmobilier? selectedTypeBienImmobilier;
  bool isLoadingBienImmobiliers = false;
  bool isLoadingTypeBienImmobiliers = false;

  File? rectoFile;
  File? versoFile;
  File? principalePicture;

  void setRecto(File file) {
    rectoFile = file;
    notifyListeners();
  }

  void setVerso(File file) {
    versoFile = file;
    notifyListeners();
  }

  void setPrincipalePicture(File file) {
    principalePicture = file;
    notifyListeners();
  }

  void setSelectedBienImmobilier(BienImmobilier bienImmobilier) {
    selectedBienImmobilier = bienImmobilier;
    notifyListeners();
  }

  List<BienImmobilier> bienImmobiliers = [];
  List<BienImmobilier> filteredBienImmobiliers = [];
  List<TypeBienImmobilier> filteredTypeBiens = [];
  List<TypeBienImmobilier> typesBiens = [];
  String searchQuery = '';

  void updateSearchQueryBiensImmobiliers(String query) {
    searchQuery = query;

    if (query.isEmpty) {
      filteredBienImmobiliers = bienImmobiliers;
    } else {
      filteredBienImmobiliers = bienImmobiliers.where((bien) {
        final fullName =
        "${bien.titre} "
            "${bien.adresse}"
            .toLowerCase();
        return fullName.contains(query.toLowerCase());
      }).toList();
    }

    notifyListeners();
  }

  void filterBiensByType(TypeBienImmobilier? typeBien) {
    selectedTypeBienImmobilier = typeBien;

    if (typeBien == null) {
      // afficher tous les biens par type
      filteredBienImmobiliers = bienImmobiliers;
    } else {
      filteredBienImmobiliers = bienImmobiliers.where((bien) {
        return bien.typeBien?.libelle == typeBien.libelle;
      }).toList();
    }

    notifyListeners();
  }

  void getTypeBienImmobiliers() {
    try {
      isLoadingTypeBienImmobiliers = true;
      notifyListeners();

      typesBiens = [
        TypeBienImmobilier(id: 1, libelle: "APPARTEMENT", description: ""),
        TypeBienImmobilier(id: 2, libelle: "MAISON", description: ""),
        TypeBienImmobilier(id: 3, libelle: "STUDIO", description: ""),
        TypeBienImmobilier(id: 4, libelle: "TERRAIN", description: ""),
        TypeBienImmobilier(id: 5, libelle: "BUREAU", description: ""),
        TypeBienImmobilier(id: 6, libelle: "PENTHOUSE", description: ""),
      ];
      isLoadingTypeBienImmobiliers = false;
      notifyListeners();
    } catch (e) {
      customLogger.e("Une erreur est survenue : $e");
      isLoadingTypeBienImmobiliers = false;
      notifyListeners();
    }
  }

  Future<void> getBienImmobiliers() async {
    bienImmobiliers = [

      BienImmobilier(
        adresse: "Abidjan - Biétry",
        titre: "Appartement 3 pièces",
        prix: 1500000 ,
        imageUrl:
        "https://cdn.webgenery.net/65CB393A46974247441979/1920X1440/69A7EEAA30C38276536258-006.jpg",
        photos: [
          "https://cdn.webgenery.net/65CB393A46974247441979/1920X1440/69A7EEAA30C38276536258-006.jpg",
          "https://cdn.webgenery.net/65CB393A46974247441979/1920X1440/69A7EEAA30C38276536258-001.jpg",
          "https://cdn.webgenery.net/65CB393A46974247441979/1920X1440/69A7EEAA30C38276536258-005.jpg",
          "https://cdn.webgenery.net/65CB393A46974247441979/1920X1440/69A7EEAA30C38276536258-003.jpg",
        ],
        chambres: "5",
        sallesDeBain: "4",
        parking: 3,
        typeBien: TypeBienImmobilier(libelle: "APPARTEMENT"),
        description: "Un bel appartement de standing et modernes dans un immeuble R+9 avec piscine, salle de sport. Un générateur prendra en charge les parties communes et les appartements, 1 sur presseur d’eau, 2 ascenseurs, un parking visiteurs en devanture, au RDC et 1 parking en sous-sol pour les habitants. \n PROXIMITÉS : Écoles :  Paul Langevin (TPS au CM2) – Rue du canal – Zone 4 (Établissement homologué) et Cours Sévigné (Homologation TPS au CM2) – Rue Calmette ZONE 4 et Collège/Lycée (Non homologué)\nCommerces : Divers centres commerciaux comme Carrefour, Cap Sud, Prima etc… \nCliniques :  Centre médical Prima - Prima Center et Polyclinique International Hôtel Dieu – Boulevard de Marseille",
        statut: StatutBienImmobilier.DISPONIBLE,
      ),

      BienImmobilier(
        adresse: " Abidjan - Cocody Riviera Bonoumin",
        titre: "Appartement 3 pièces",
        prix: 1200000,
        imageUrl:
        "https://cdn.webgenery.net/65CB393A46974247441979/1920X1440/667990D09912E156151748-001.jpeg",
        photos: [
          "https://cdn.webgenery.net/65CB393A46974247441979/1920X1440/667990D09912E156151748-001.jpeg",
          "https://cdn.webgenery.net/65CB393A46974247441979/1920X1440/667990D09912E156151748-002.jpeg",
          "hhttps://cdn.webgenery.net/65CB393A46974247441979/1920X1440/667990D09912E156151748-005.jpg",
          "https://cdn.webgenery.net/65CB393A46974247441979/1920X1440/667990D09912E156151748-003.jpg",
        ],
        chambres: "3",
        sallesDeBain: "2",
        parking: 2,
        typeBien: TypeBienImmobilier(libelle: "APPARTEMENT"),
        description: "Un bel appartement de standing et modernes dans un immeuble R+9 avec piscine, salle de sport. Un générateur prendra en charge les parties communes et les appartements, 1 sur presseur d’eau, 2 ascenseurs, un parking visiteurs en devanture, au RDC et 1 parking en sous-sol pour les habitants. \n PROXIMITÉS : Écoles :  Paul Langevin (TPS au CM2) – Rue du canal – Zone 4 (Établissement homologué) et Cours Sévigné (Homologation TPS au CM2) – Rue Calmette ZONE 4 et Collège/Lycée (Non homologué)\nCommerces : Divers centres commerciaux comme Carrefour, Cap Sud, Prima etc… \nCliniques :  Centre médical Prima - Prima Center et Polyclinique International Hôtel Dieu – Boulevard de Marseille",

        statut: StatutBienImmobilier.DISPONIBLE,
      ),


      BienImmobilier(
        adresse: "Marcory Résidentiel",
        titre: "Villa ",
        prix: 1300000,
        imageUrl:
        "https://cdn.webgenery.net/65CB393A46974247441979/1920X1440/69A7EEAA30C38276536258-001.jpg",
        photos: [
          "https://cdn.webgenery.net/65CB393A46974247441979/1920X1440/69A7EEAA30C38276536258-001.jpg",
          "https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?auto=format&fit=crop&w=1200&q=80",
          "https://images.unsplash.com/photo-1505693416388-ac5ce068fe85?auto=format&fit=crop&w=1200&q=80",
        ],
        chambres: "3",
        sallesDeBain: "3",
        parking: 1,
        typeBien: TypeBienImmobilier(libelle: "MAISON"),
        statut: StatutBienImmobilier.DISPONIBLE,
      ),


      BienImmobilier(
        adresse: "Assinie Mafia Km 19",
        titre: "Propriété - Assinie",
        prix: 450000000,
        imageUrl:
        "https://cdn.webgenery.net/65CB393A46974247441979/1920X1440/68360EE840D46197437526-021.jpg",
        photos: [
          "https://cdn.webgenery.net/65CB393A46974247441979/1920X1440/68360EE840D46197437526-021.jpg",
          "https://cdn.webgenery.net/65CB393A46974247441979/1920X1440/68360EE840D46197437526-001.jpg",
          "https://cdn.webgenery.net/65CB393A46974247441979/1920X1440/68360EE840D46197437526-006.jpg",
        ],
        chambres: "4",
        sallesDeBain: "4",
        parking: 3,
        typeBien: TypeBienImmobilier(libelle: "MAISON"),
     description: "Situé à Assinie Mafia, km 19, côté mer non loin de l’hôtel Key 19. Parking et traversée : Pk 18,\n PROXIMITÉS :  Village Assinie Mafia – Super Marché Bon Prix – Rue Calmette ZONE 4 et Collège/Lycée (Non homologué)\nCommerces : Divers hôtels  comme Carrefour, Coucoué Lodge, Les Marines de Babihana, La Maison d’Akoula, le Zion, etc…",
        statut: StatutBienImmobilier.DISPONIBLE,
      ),

    ];

    filteredBienImmobiliers = bienImmobiliers;
    notifyListeners();
  }
}


