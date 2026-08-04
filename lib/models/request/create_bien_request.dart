import 'package:pisso/models/type_bien.dart';


class CreateBienRequest {
  final TypeBienImmobilier type;
  final String nom;
  final String description;
  final int chambres;
  final int salons;
  final int sallesBain;
  final double surface;
  final int etage;
  final bool parking;
  final bool piscine;
  final bool jardin;
  final bool meuble;
  final bool climatisation;
  final bool ascenseur;
  final String adresse;
  final String commune;
  final String quartier;
  final double? latitude;
  final double? longitude;
  final List<String> centresInteret;
  final List<String> imagePaths;
  final List<String> videoPaths;
  final List<String> documentPaths;

  const CreateBienRequest({
    required this.type,
    required this.nom,
    required this.description,
    required this.chambres,
    required this.salons,
    required this.sallesBain,
    required this.surface,
    required this.etage,
    required this.parking,
    required this.piscine,
    required this.jardin,
    required this.meuble,
    required this.climatisation,
    required this.ascenseur,
    required this.adresse,
    required this.commune,
    required this.quartier,
    this.latitude,
    this.longitude,
    this.centresInteret = const [],
    this.imagePaths = const [],
    this.videoPaths = const [],
    this.documentPaths = const [],
  });

  Map<String, dynamic> toJson() => {
        'type': type.libelle,
        'nom': nom,
        'description': description,
        'chambres': chambres,
        'salons': salons,
        'sallesBain': sallesBain,
        'surface': surface,
        'etage': etage,
        'parking': parking,
        'piscine': piscine,
        'jardin': jardin,
        'meuble': meuble,
        'climatisation': climatisation,
        'ascenseur': ascenseur,
        'adresse': adresse,
        'commune': commune,
        'quartier': quartier,
        'latitude': latitude,
        'longitude': longitude,
        'centresInteret': centresInteret,
        'imagePaths': imagePaths,
        'videoPaths': videoPaths,
        'documentPaths': documentPaths,
      };
}

