/// Modèle utilisateur — profil Domus CI.
class AppUser {
  final String id;
  final String fullName;
  final String phone;
  final String avatarUrl;
  final bool isVerified;
  final int listingsCount;
  final int favoritesCount;
  final int visitsCount;

  const AppUser({
    required this.id,
    required this.fullName,
    required this.phone,
    required this.avatarUrl,
    this.isVerified = false,
    this.listingsCount = 0,
    this.favoritesCount = 0,
    this.visitsCount = 0,
  });

  static const AppUser demo = AppUser(
    id: 'u1',
    fullName: 'Kouassi Aya',
    phone: '+225 07 12 34 56 78',
    avatarUrl: 'https://images.unsplash.com/photo-1531123897727-8f129e1688ce?q=80&w=200&auto=format&fit=crop',
    isVerified: true,
    listingsCount: 12,
    favoritesCount: 34,
    visitsCount: 128,
  );
}

