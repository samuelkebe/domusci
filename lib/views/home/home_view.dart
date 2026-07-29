import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/lucide.dart';
import 'package:provider/provider.dart';

import '../../models/property.dart';
import '../../ressources/app_colors.dart';
import '../../ressources/app_spacing.dart';
import '../../ressources/app_text_styles.dart';
import '../../views-models/explore_viewmodel.dart';
import '../property/property_detail_view.dart';
import '../widgets/loaders/skeleton_loader.dart';

/// Vue — Explorer : recherche, filtres rapides, carte interactive,
/// quartiers populaires et liste des annonces.
///
/// Traduction Flutter du mockup HTML "Domus CI - Explorer".
class HomeView extends StatelessWidget {
  const HomeView({super.key});

  static const _categories = [
    (icon: Lucide.building_2, label: 'Appartement', type: PropertyType.appartement),
    (icon: Lucide.home, label: 'Maison', type: PropertyType.maison),
    (icon: Lucide.landmark, label: 'Villa', type: PropertyType.villa),
    (icon: Lucide.map, label: 'Terrain', type: PropertyType.terrain),
  ];

  static const _quartiers = ['Cocody', 'Plateau', 'Marcory', 'Riviera', 'Angré'];

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ExplorerViewModel>();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          SafeArea(
            bottom: false,
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 90, 20, 110),
              children: [
                // _SearchBar(controller: vm.searchController, onFilterTap: vm.openFilters),
                const SizedBox(height: AppSpacing.lg),
                SizedBox(
                  height: 44,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: _categories.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                    itemBuilder: (context, i) {
                      final c = _categories[i];
                      return _CategoryPill(
                        icon: c.icon,
                        label: c.label,
                        active: vm.selectedCategoryIndex == i,
                        onTap: () => vm.selectCategory(i),
                      );
                    },
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),
                _MapTeaser(onTap: vm.openMap),
                const SizedBox(height: AppSpacing.xl),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Quartiers populaires', style: AppTextStyles.h4),
                    GestureDetector(
                      onTap: vm.seeAllQuartiers,
                      child: Text('Tout voir',
                          style: AppTextStyles.bodySm.copyWith(color: AppColors.primary, fontWeight: FontWeight.w700)),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _quartiers
                      .map((q) => _QuartierChip(name: q, onTap: () => vm.filterByQuartier(q)))
                      .toList(),
                ),
                const SizedBox(height: AppSpacing.xl),
                if (vm.isLoading)
                  Column(
                    children: List.generate(2, (_) => const Padding(
                      padding: EdgeInsets.only(bottom: AppSpacing.lg),
                      child: PropertyCardSkeleton(fullWidth: true),
                    )),
                  )
                else
                  Column(
                    children: vm.listings
                        .map((p) => Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.lg),
                      child: _PropertyListingCard(
                        property: p,
                        isFavorite: vm.isFavorite(p),
                        onFavoriteToggle: () => vm.toggleFavorite(p),
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => PropertyDetailView(propertyId: p.id)),
                        ),
                      ),
                    ))
                        .toList(),
                  ),
              ],
            ),
          ),
          _TopAppBar(avatarUrl: vm.currentUserAvatarUrl, onNotificationsTap: vm.openNotifications),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: FloatingActionButton(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          shape: const CircleBorder(),
          onPressed: vm.openChat,
          child: const Iconify(Lucide.message_circle, size: 22, color: Colors.white),
        ),
      ),
    );
  }
}

/// Barre supérieure translucide avec avatar, titre et notifications.
class _TopAppBar extends StatelessWidget {
  final String avatarUrl;
  final VoidCallback onNotificationsTap;
  const _TopAppBar({required this.avatarUrl, required this.onNotificationsTap});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: AppColors.background.withOpacity(0.7),
            boxShadow: [
              BoxShadow(color: AppColors.primary.withOpacity(0.08), blurRadius: 20, offset: const Offset(0, 4)),
            ],
          ),
          child: SafeArea(
            bottom: false,
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(avatarUrl, width: 40, height: 40, fit: BoxFit.cover),
                ),
                const SizedBox(width: AppSpacing.sm),
                Text('Explorer', style: AppTextStyles.h3.copyWith(color: AppColors.primary, fontWeight: FontWeight.bold)),
                const Spacer(),
                GestureDetector(
                  onTap: onNotificationsTap,
                  child: const Iconify(Lucide.bell, size: 24, color: AppColors.primary),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Champ de recherche + bouton de filtre.
class _SearchBar extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onFilterTap;
  const _SearchBar({required this.controller, required this.onFilterTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 56,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.border),
              boxShadow: const [BoxShadow(color: Color(0x0F000000), blurRadius: 6, offset: Offset(0, 2))],
            ),
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                prefixIcon: Padding(
                  padding: EdgeInsets.all(14),
                  child: Iconify(Lucide.search, size: 20, color: AppColors.textSecondary),
                ),
                hintText: 'Rechercher à Cocody, Plateau...',
              ),
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        GestureDetector(
          onTap: onFilterTap,
          child: Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.12),
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [BoxShadow(color: Color(0x1A000000), blurRadius: 8, offset: Offset(0, 2))],
            ),
            child: const Iconify(Lucide.sliders_horizontal, size: 20, color: AppColors.primary),
          ),
        ),
      ],
    );
  }
}

/// Pastille de catégorie rapide (Appartement, Maison, Villa, Terrain).
class _CategoryPill extends StatelessWidget {
  final String icon;
  final String label;
  final bool active;
  final VoidCallback onTap;
  const _CategoryPill({required this.icon, required this.label, required this.active, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: active ? AppColors.primary : AppColors.tertiary.withOpacity(0.15),
          borderRadius: BorderRadius.circular(100),
          border: active ? null : Border.all(color: AppColors.tertiary.withOpacity(0.2)),
          boxShadow: active ? [BoxShadow(color: AppColors.primary.withOpacity(0.3), blurRadius: 8, offset: const Offset(0, 3))] : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Iconify(icon, size: 16, color: active ? Colors.white : AppColors.textPrimary),
            const SizedBox(width: 6),
            Text(label,
                style: AppTextStyles.label.copyWith(color: active ? Colors.white : AppColors.textPrimary)),
          ],
        ),
      ),
    );
  }
}

/// Bannière "carte interactive" avec overlay glassmorphism.
class _MapTeaser extends StatelessWidget {
  final VoidCallback onTap;
  const _MapTeaser({required this.onTap});

  static const _mapImageUrl =
      'https://lh3.googleusercontent.com/aida-public/AB6AXuC-WCImlZxjeWBPgIQbXLJq4WBPkwC_-EFL-xFjU16gvxrQP9PbqXWwFORJgl02ABMhFVbASYV5N80nBfqFkxZVwmKPZIGz7uyOvYqwi99QgwBn7-zwioIV8ZvQ8309gpVi_D_7LsqkGctTb8dn1XuM2mvdfpukChYxFGf3kLj2Eb5hxRvHT8jicCLy_cwWwQzI2_9DVJuN3VAmASp3SHcsVVXpVcxUOAgSoGOU6DOFtv1n3YtW7AxYQijTsntKhpf24lJ_XiV9BcVR';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 220,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border.withOpacity(0.3)),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(_mapImageUrl, fit: BoxFit.cover),
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Color(0x66000000), Colors.transparent],
                ),
              ),
            ),
            Positioned(
              left: 16,
              right: 16,
              bottom: 16,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.white.withOpacity(0.2)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('VUE INTERACTIVE',
                                style: AppTextStyles.caption.copyWith(
                                    color: AppColors.primary, fontWeight: FontWeight.w700, letterSpacing: 1)),
                            const SizedBox(height: 2),
                            Text('Explorer la carte des prix',
                                style: AppTextStyles.bodySm.copyWith(fontWeight: FontWeight.w600)),
                          ],
                        ),
                        Container(
                          width: 40,
                          height: 40,
                          decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                          child: const Iconify(Lucide.map, size: 18, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Chip de quartier populaire (Cocody, Plateau, etc.).
class _QuartierChip extends StatelessWidget {
  final String name;
  final VoidCallback onTap;
  const _QuartierChip({required this.name, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(100),
          border: Border.all(color: AppColors.border.withOpacity(0.3)),
        ),
        child: Text(name, style: AppTextStyles.label),
      ),
    );
  }
}

/// Carte d'annonce pleine largeur : image, badge, favori, prix et specs.
class _PropertyListingCard extends StatelessWidget {
  final Property property;
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;
  final VoidCallback onTap;

  const _PropertyListingCard({
    required this.property,
    required this.isFavorite,
    required this.onFavoriteToggle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isForRent = property.id == property.quartier;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border.withOpacity(0.1)),
          boxShadow: [BoxShadow(color: AppColors.primary.withOpacity(0.08), blurRadius: 20, offset: const Offset(0, 4))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 256,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // Image.network(property.coverImageUrl, fit: BoxFit.cover),
                  Positioned(
                    top: 16,
                    left: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: isForRent ? AppColors.primary : AppColors.secondary,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Text(isForRent ? 'À louer' : 'À vendre',
                          style: AppTextStyles.caption.copyWith(color: Colors.white, fontWeight: FontWeight.w700)),
                    ),
                  ),
                  Positioned(
                    top: 16,
                    right: 16,
                    child: GestureDetector(
                      onTap: onFavoriteToggle,
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(color: Colors.white.withOpacity(0.8), shape: BoxShape.circle),
                        child: Iconify(
                          isFavorite ? Lucide.heart : Lucide.heart,
                          size: 18,
                          color: isFavorite ? AppColors.favorite : AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: Text(property.title, style: AppTextStyles.h4)),
                      RichText(
                        text: TextSpan(
                          style: AppTextStyles.h4.copyWith(color: AppColors.primary),
                          children: [
                            TextSpan(text: property.price),
                            TextSpan(
                              text: isForRent ? ' FCFA/mois' : ' FCFA',
                              style: AppTextStyles.label.copyWith(color: AppColors.textSecondary, fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Iconify(Lucide.map_pin, size: 16, color: AppColors.textSecondary),
                      const SizedBox(width: 4),
                      Text(property.distance, style: AppTextStyles.bodySm.copyWith(color: AppColors.textSecondary)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.only(top: 12),
                    decoration: BoxDecoration(border: Border(top: BorderSide(color: AppColors.tertiary.withOpacity(0.3)))),
                    child: Row(
                      children: [
                        _SpecItem(icon: Lucide.bed, label: '${property.bedrooms} Ch.'),
                        const SizedBox(width: 24),
                        _SpecItem(icon: Lucide.bath, label: '${property.bathrooms} Sdb.'),
                        const SizedBox(width: 24),
                        _SpecItem(icon: Lucide.ruler, label: '${property.surface} m²'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SpecItem extends StatelessWidget {
  final String icon;
  final String label;
  const _SpecItem({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Iconify(icon, size: 18, color: AppColors.primary),
        const SizedBox(width: 4),
        Text(label, style: AppTextStyles.label),
      ],
    );
  }
}