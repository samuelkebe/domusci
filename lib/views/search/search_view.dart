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

/// Vue — Recherche : filtres avancés, vue liste / carte.
class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<SearchViewModel>();
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 6, 20, 0),
            child: Row(
              children: [
                Expanded(child: DomusSearchBar(onFilterTap: () => _openFilters(context, vm))),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                DomusChip(label: 'Tous', active: vm.typeFilter == null, onTap: () => vm.setTypeFilter(null)),
                const SizedBox(width: 8),
                DomusChip(
                  label: 'Appartement',
                  icon: Lucide.building_2,
                  active: vm.typeFilter == PropertyType.appartement,
                  onTap: () => vm.setTypeFilter(PropertyType.appartement),
                ),
                const SizedBox(width: 8),
                DomusChip(
                  label: 'Villa',
                  icon: Lucide.landmark,
                  active: vm.typeFilter == PropertyType.villa,
                  onTap: () => vm.setTypeFilter(PropertyType.villa),
                ),
                const SizedBox(width: 8),
                DomusChip(
                  label: 'Terrain',
                  icon: Lucide.map,
                  active: vm.typeFilter == PropertyType.terrain,
                  onTap: () => vm.setTypeFilter(PropertyType.terrain),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich(
                  TextSpan(style: AppTextStyles.bodySm, children: [
                    TextSpan(text: '${vm.results.length} ', style: AppTextStyles.bodyMd.copyWith(fontWeight: FontWeight.w800)),
                    const TextSpan(text: 'biens trouvés'),
                  ]),
                ),
                Row(
                  children: [
                    _ModeButton(
                      icon: Lucide.layout_grid,
                      active: vm.displayMode == SearchDisplayMode.list,
                      onTap: () => vm.setDisplayMode(SearchDisplayMode.list),
                    ),
                    const SizedBox(width: 8),
                    _ModeButton(
                      icon: Lucide.map,
                      active: vm.displayMode == SearchDisplayMode.map,
                      onTap: () => vm.setDisplayMode(SearchDisplayMode.map),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Expanded(child: _buildBody(context, vm)),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context, SearchViewModel vm) {
    if (vm.isLoading) {
      return ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: 4,
        separatorBuilder: (_, __) => const SizedBox(height: 14),
        itemBuilder: (_, __) => const PropertyCardSkeleton(width: double.infinity, fullWidth: null,),
      );
    }
    if (vm.results.isEmpty) {
      return Center(
        child: EmptyState(
          icon: Lucide.search,
          title: 'Aucun résultat',
          description: 'Essayez de modifier vos filtres ou votre zone de recherche.',
        ),
      );
    }
    if (vm.displayMode == SearchDisplayMode.map) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(color: AppColors.tertiary, borderRadius: BorderRadius.circular(20)),
        alignment: Alignment.center,
        child: const Iconify(Lucide.map_pin, size: 46, color: Colors.white),
      );
    }
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
      itemCount: vm.results.length,
      separatorBuilder: (_, __) => const SizedBox(height: 14),
      itemBuilder: (context, i) {
        final p = vm.results[i];
        return PropertyCard(
          property: p,
          variant: PropertyCardVariant.horizontal,
          onFavoriteToggle: () => vm.toggleFavorite(p),
          onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => PropertyDetailView(propertyId: p.id))),
        );
      },
    );
  }

  void _openFilters(BuildContext context, SearchViewModel vm) {
    // Le bottom sheet de filtres avancés (prix, surface, chambres, piscine…)
    // peut être branché ici via showDomusBottomSheet().
  }
}

class _ModeButton extends StatelessWidget {
  final String icon;
  final bool active;
  final VoidCallback onTap;
  const _ModeButton({required this.icon, required this.active, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 34,
        height: 34,
        decoration: BoxDecoration(
          color: active ? AppColors.primary : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: active ? AppColors.primary : AppColors.border),
        ),
        child: Iconify(icon, size: 15, color: active ? Colors.white : AppColors.textSecondary),
      ),
    );
  }
}
