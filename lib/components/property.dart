enum PropertyBadge { none, nouveau, exclusif, coupDeCoeur }
enum PropertyType { appartement, maison, villa, terrain, bureau, boutique }

class Property {
  final String id;
  final String imageUrl;
  final List<String> gallery;
  final PropertyBadge badge;
  final String price;
  final String title;
  final String quartier;
  final String surface;
  final int? bedrooms;
  final int? bathrooms;
  final bool hasParking;
  final String distance;
  bool isFavorite;
  final PropertyType type;
  final String description;
  final List<String> amenities;
  final String ownerName;
  final String ownerType;
  final String ownerAvatar;

  Property({
    required this.id,
    required this.imageUrl,
    this.gallery = const [],
    required this.badge,
    required this.price,
    required this.title,
    required this.quartier,
    required this.surface,
    this.bedrooms,
    this.bathrooms,
    this.hasParking = false,
    required this.distance,
    this.isFavorite = false,
    this.type = PropertyType.appartement,
    this.description = '',
    this.amenities = const [],
    this.ownerName = '',
    this.ownerType = '',
    this.ownerAvatar = '',
  });

  String get badgeLabel {
    switch (badge) {
      case PropertyBadge.nouveau:
        return 'Nouveau';
      case PropertyBadge.exclusif:
        return 'Exclusif';
      case PropertyBadge.coupDeCoeur:
        return 'Coup de cœur';
      case PropertyBadge.none:
        return '';
    }
  }
}

