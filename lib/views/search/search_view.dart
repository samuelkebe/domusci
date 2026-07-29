import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/lucide.dart';
import 'package:provider/provider.dart';
import '../../models/property.dart';
import '../../ressources/app_colors.dart';
import '../../ressources/app_spacing.dart';
import '../../ressources/app_text_styles.dart';
import '../../views-models/search_view_model.dart';
import '../property/property_detail_view.dart';
import '../widgets/cards/property_card.dart';
import '../widgets/chips/category_chip.dart';
import '../widgets/loaders/skeleton_loader.dart';
import '../widgets/search/domus_search_bar.dart';
import '../widgets/states/empty_state.dart';

/// Vue — Recherche : carte (placeholder) + filtres + panneau de résultats.
class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<SearchViewModel>();

    return Scaffold(
      body: Stack(
        children: [
          // Fond de carte (simple placeholder — à remplacer par une vraie carte).
          Positioned.fill(
            child: _MapPlaceholder(
              property:  null,
            ),
          ),

          // Barre de recherche + filtre + chips, en haut de l'écran.
          SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 6, 20, 0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: DomusSearchBar(hint: 'Rechercher par quartier…'),
                      ),
                      const SizedBox(width: 10),
                      _FilterButton(onTap: () => _openFilters(context)),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.md),
                  SizedBox(
                    height: 38,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        DomusChip(
                          label: 'Tous',
                          // active: vm.typeFilter == null,
                          // onTap: () => vm.setTypeFilter(null),
                        ),
                        const SizedBox(width: 8),
                        DomusChip(
                          label: 'Appartement',
                          icon: Lucide.building_2,
                          // active: vm.typeFilter == PropertyType.appartement,
                          // onTap: () => vm.setTypeFilter(PropertyType.appartement),
                        ),
                        const SizedBox(width: 8),
                        DomusChip(
                          label: 'Villa',
                          icon: Lucide.landmark,
                          // active: vm.typeFilter == PropertyType.villa,
                          // onTap: () => vm.setTypeFilter(PropertyType.villa),
                        ),
                        const SizedBox(width: 8),
                        DomusChip(
                          label: 'Terrain',
                          icon: Lucide.map,
                          // active: vm.typeFilter == PropertyType.terrain,
                          // onTap: () => vm.setTypeFilter(PropertyType.terrain),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Panneau de résultats en bas de l'écran.
          DraggableScrollableSheet(
            initialChildSize: 0.42,
            minChildSize: 0.42,
            maxChildSize: 0.9,
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(AppSpacing.radiusCard),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 24,
                      offset: Offset(0, -6),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 12),
                    Container(
                      width: 40,
                      height: 5,
                      decoration: BoxDecoration(
                        color: AppColors.border,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 14, 20, 4),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Recommandé pour vous',
                          style: AppTextStyles.h4,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        // child: Text('${vm.results.length} biens trouvés', style: AppTextStyles.bodySm),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _openFilters(BuildContext context) {
    // Le bottom sheet de filtres avancés (prix, surface, chambres, piscine…)
    // peut être branché ici via showDomusBottomSheet().
  }
}

/// Bouton rond du filtre, à côté de la barre de recherche.
class _FilterButton extends StatelessWidget {
  final VoidCallback onTap;
  const _FilterButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          border: Border.all(color: AppColors.border),
          boxShadow: const [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 18,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: const Iconify(
          Lucide.sliders_horizontal,
          size: 18,
          color: AppColors.primary,
        ),
      ),
    );
  }
}

/// Fond de carte simplifié : un simple aplat coloré + un repère sur un bien.
/// À remplacer par `google_maps_flutter` ou `flutter_map` pour une vraie carte.
class _MapPlaceholder extends StatelessWidget {
  final Property? property;
  const _MapPlaceholder({this.property});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.tertiary,
      child: property == null
          ? null
          : Center(child: _PropertyMarker(property: property!)),
    );
  }
}

/// Petite bulle "photo + nom du bien" affichée sur la carte.
class _PropertyMarker extends StatelessWidget {
  final Property property;
  const _PropertyMarker({required this.property});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 6, right: 14, top: 6, bottom: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(100),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 14,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.network(
              property.imageUrl,
              width: 34,
              height: 34,
              fit: BoxFit.cover,
              errorBuilder: (c, e, s) =>
                  Container(width: 34, height: 34, color: AppColors.secondary),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            property.title,
            style: AppTextStyles.bodySm.copyWith(fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
