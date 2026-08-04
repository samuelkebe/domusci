import 'package:pisso/models/type_bien.dart';

import 'enum/statut_bien_immobilier.dart';

class BienImmobilier {
  int? id;
  String? titre;
  String? description;
  String? adresse;
  String? quartier;
  String? ville;
  String? pays;
  double? prix;
  String? devise;
  double? surface;
  String? uniteSurface;
  String? chambres;
  String? sallesDeBain;
  int? parking;
  TypeBienImmobilier? typeBien;
  StatutBienImmobilier? statut;
  String? imageUrl;
  final List<String>? photos;
  String? proprietaire;
  String? contactProprietaire;
  DateTime? datePublication;
  bool? isPremium;
  bool? isFeatured;
  double? latitude;
  double? longitude;
  List<String>? images;
  List<String>? equipements;

  BienImmobilier({
    this.id,
    this.titre,
    this.description,
    this.adresse,
    this.quartier,
    this.ville,
    this.pays,
    this.prix,
    this.devise,
    this.surface,
    this.uniteSurface,
    this.chambres,
    this.sallesDeBain,
    this.parking,
    this.photos,
    this.typeBien,
    this.statut,
    this.imageUrl,
    this.proprietaire,
    this.contactProprietaire,
    this.datePublication,
    this.isPremium,
    this.isFeatured,
    this.latitude,
    this.longitude,
    this.images,
    this.equipements,
  });

  factory BienImmobilier.fromJson(Map<String, dynamic> json) {
    return BienImmobilier(
      id: json['id'],
      titre: json['titre'],
      description: json['description'],
      adresse: json['adresse'],
      quartier: json['quartier'],
      ville: json['ville'],
      pays: json['pays'],
      prix: json['prix']?.toDouble(),
      devise: json['devise'],
      surface: json['surface']?.toDouble(),
      uniteSurface: json['uniteSurface'],
      chambres: json['chambres'],
      sallesDeBain: json['sallesDeBain'],
      parking: json['parking'],
      typeBien: json['typeBien'] != null
          ? TypeBienImmobilier.fromJson(json['typeBien'])
          : null,
      statut: json['statut'] != null
          ? StatutBienImmobilier.fromString(json['statut'])
          : null,
      imageUrl: json['imageUrl'],
      proprietaire: json['proprietaire'],
      contactProprietaire: json['contactProprietaire'],
      datePublication: json['datePublication'] != null
          ? DateTime.parse(json['datePublication'])
          : null,
      isPremium: json['isPremium'],
      isFeatured: json['isFeatured'],
      latitude: json['latitude']?.toDouble(),
      longitude: json['longitude']?.toDouble(),
      images: json['images'] != null
          ? List<String>.from(json['images'])
          : null,
      equipements: json['equipements'] != null
          ? List<String>.from(json['equipements'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'titre': titre,
      'description': description,
      'adresse': adresse,
      'quartier': quartier,
      'ville': ville,
      'pays': pays,
      'prix': prix,
      'devise': devise,
      'surface': surface,
      'uniteSurface': uniteSurface,
      'chambres': chambres,
      'sallesDeBain': sallesDeBain,
      'parking': parking,
      'typeBien': typeBien,
      'statut': statut?.name,
      'imageUrl': imageUrl,
      'proprietaire': proprietaire,
      'contactProprietaire': contactProprietaire,
      'datePublication': datePublication?.toIso8601String(),
      'isPremium': isPremium,
      'isFeatured': isFeatured,
      'latitude': latitude,
      'longitude': longitude,
      'images': images,
      'equipements': equipements,
    };
  }

  String get prixFormate {
    if (prix == null) return "0 FCFA";
    if (prix! >= 1000000) {
      return '${(prix! / 1000000).toStringAsFixed(1)}M FCFA';
    } else if (prix! >= 1000) {
      return '${(prix! / 1000).toStringAsFixed(0)}K FCFA';
    }
    return '${prix!.toInt()} FCFA';
  }
}

