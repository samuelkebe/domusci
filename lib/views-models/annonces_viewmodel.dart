import 'package:flutter/cupertino.dart';

import '../models/annonce.dart';
import '../models/bien_immobilier_model.dart';
import '../models/enum/statut_annonce.dart';
import '../models/enum/type_offre.dart';
import '../models/type_bien.dart';
import '../utils/log_config.dart';

class AnnoncesViewmodel extends ChangeNotifier {
  List<Annonce> annonces = [];
  Annonce? selectedAnnonce;
  bool isLoadingAnnonces = false;

  void setSelectedAnnonce(Annonce? annonce) {
    selectedAnnonce = annonce;
    notifyListeners();
  }


  void getAnnonces() {
    try {
      isLoadingAnnonces = true;
      annonces = [
        Annonce(
          libelle: "Appartement moderne 3 pièces à Cocody",
          description:
          "Bel appartement situé dans une résidence sécurisée avec parking, balcon et espace vert.",
          typeOffre: TypeOffre.LOCATION,
          typeBienImmobilier: TypeBienImmobilier(
            libelle: "APPARTEMENT",
          ),
          statutAnnonce: StatutAnnonce.EXPIRE,
          bienImmobilier: BienImmobilier(
            id: 001,
            adresse: "Cocody Riviera 3",
            prix: 350000,
          ),
          images: [
            "https://images.unsplash.com/photo-1600607687939-ce8a6c25118c",
            "https://images.unsplash.com/photo-1600566753086-00f18fb6b3ea",
          ],
          negociable: false,
          disponible: true,
          dateLiberation: DateTime(2026, 9, 1),
          dateCreation: DateTime.now(),
        ),
        Annonce(
          libelle: "Villa duplex avec piscine à Bingerville",
          description:
          "Magnifique villa duplex de haut standing avec piscine, jardin et garage privé.",
          typeOffre: TypeOffre.VENTE,
          typeBienImmobilier: TypeBienImmobilier(
            libelle: "VILLA",
          ),
          statutAnnonce: StatutAnnonce.VALABLE,
          bienImmobilier: BienImmobilier(
            id: 002,
            adresse: "Bingerville, Abatta",
            prix: 85000000,
          ),
          images: [
            "https://images.unsplash.com/photo-1600585154340-be6161a56a0c",
            "https://images.unsplash.com/photo-1600607688969-a5bfcd646154",
          ],
          negociable: true,
          disponible: true,
          dateLiberation: DateTime(2026, 10, 15),
          dateCreation: DateTime.now(),
        ),
        Annonce(
          libelle: "Chambre en colocation proche université",
          description:
          "Chambre disponible dans un appartement partagé avec cuisine équipée et wifi.",
          typeOffre: TypeOffre.CO_LOCATION,
          typeBienImmobilier: TypeBienImmobilier(
            libelle: "CHAMBRE",
          ),
          statutAnnonce: StatutAnnonce.VALABLE,
          bienImmobilier: BienImmobilier(
            id: 003,
            adresse: "Cocody Deux Plateaux",
            prix: 75000,
          ),
          images: [
            "https://images.unsplash.com/photo-1616486338812-3dadae4b4ace",
          ],
          negociable: false,
          disponible: true,
          dateLiberation: DateTime(2026, 8, 20),
          dateCreation: DateTime.now(),
        ),
        Annonce(
          libelle: "Studio meublé moderne Zone 4",
          description:
          "Studio entièrement meublé avec climatisation, internet et service de sécurité.",
          typeOffre: TypeOffre.LOCATION,
          typeBienImmobilier: TypeBienImmobilier(
            libelle: "STUDIO",
          ),
          statutAnnonce: StatutAnnonce.EXPIRE,
          bienImmobilier: BienImmobilier(
            id: 004,
            adresse: "Marcory Zone 4",
            prix: 250000,
          ),
          images: [
            "https://images.unsplash.com/photo-1505693416388-ac5ce068fe85",
            "https://images.unsplash.com/photo-1615874694520-474822394e65",
          ],
          negociable: true,
          disponible: true,
          dateLiberation: DateTime(2026, 9, 10),
          dateCreation: DateTime.now(),
        ),
        Annonce(
          libelle: "Terrain résidentiel 600 m²",
          description:
          "Terrain idéal pour construction d'une maison familiale dans une zone en développement.",
          typeOffre: TypeOffre.VENTE,
          typeBienImmobilier: TypeBienImmobilier(
            libelle: "TERRAIN",
          ),
          statutAnnonce: StatutAnnonce.VALABLE,
          bienImmobilier: BienImmobilier(
            id: 005,
            adresse: "Assinie Km 5",
            prix: 30000000,
          ),
          images: [
            "https://images.unsplash.com/photo-1500382017468-9049fed747ef",
          ],
          negociable: true,
          disponible: true,
          dateLiberation: DateTime(2026, 12, 1),
          dateCreation: DateTime.now(),
        ),

      ];
      customLogger.i("Nbres annonces : ${annonces.length}");

      notifyListeners();

    } catch (e) {
      customLogger.e("Une erreur est survenue : $e");

    } finally {
      isLoadingAnnonces = false;
      notifyListeners();
    }
  }  void updateAnnonce() {
    notifyListeners();
  }


  void clearAnnonces() {
    annonces.clear();
    notifyListeners();
  }

  void addAnnonce(Annonce annonce) {
    annonces.add(annonce);
    notifyListeners();
  }

  void removeAnnonce(Annonce annonce) {
    annonces.remove(annonce);
    notifyListeners();
  }

}