import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/lucide.dart';
import 'package:provider/provider.dart';
import '../../ressources/app_colors.dart';
import '../../ressources/app_spacing.dart';
import '../../ressources/app_text_styles.dart';
import '../../views-models/property_detail_view_model.dart';
import '../widgets/app_bar/domus_app_bar.dart';
import '../widgets/badges/domus_badge.dart';
import '../widgets/buttons/primary_button.dart';

/// Vue — Détail d'un bien : galerie, description, commodités, propriétaire.
class PropertyDetailView extends StatelessWidget {
  final String propertyId;
  const PropertyDetailView({super.key, required this.propertyId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PropertyDetailViewModel()..load(propertyId),
      child: Consumer<PropertyDetailViewModel>(
        builder: (context, vm, _) {
          if (vm.isLoading || vm.property == null) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              ),
            );
          }
          final p = vm.property!;
          return Scaffold(
            backgroundColor: Colors.white,
            body: Stack(
              children: [
                CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Stack(
                        children: [
                          Hero(
                            tag: 'property-${p.id}',
                            child: Image.network(
                              p.imageUrl,
                              height: 300,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            bottom: 14,
                            right: 16,
                            child: _pill(
                              Lucide.camera,
                              '1 / ${p.gallery.isEmpty ? 1 : p.gallery.length}',
                            ),
                          ),
                          Positioned(
                            bottom: 14,
                            left: 16,
                            child: _pill(
                              Lucide.play_circle,
                              'Visite virtuelle',
                            ),
                          ),
                        ],
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        transform: Matrix4.translationValues(0, -22, 0),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(AppSpacing.radiusCard),
                          ),
                        ),
                        padding: const EdgeInsets.fromLTRB(22, 22, 22, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DomusBadge(badge: p.badge),
                            const SizedBox(height: 8),
                            Text(p.title, style: AppTextStyles.h3),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                const Iconify(
                                  Lucide.map_pin,
                                  size: 13,
                                  color: AppColors.textSecondary,
                                ),
                                const SizedBox(width: 4),
                                Text(p.quartier, style: AppTextStyles.bodySm),
                              ],
                            ),
                            const SizedBox(height: 18),
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              decoration: const BoxDecoration(
                                border: Border(
                                  top: BorderSide(color: AppColors.border),
                                  bottom: BorderSide(color: AppColors.border),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  if (p.bedrooms != null)
                                    _stat(
                                      Lucide.bed_double,
                                      '${p.bedrooms} chambres',
                                    ),
                                  if (p.bathrooms != null)
                                    _stat(Lucide.bath, '${p.bathrooms} sdb'),
                                  if (p.hasParking)
                                    _stat(Lucide.car, 'Parking'),
                                  _stat(Lucide.ruler, p.surface),
                                ],
                              ),
                            ),
                            const SizedBox(height: 18),
                            Text('Description', style: AppTextStyles.h4),
                            const SizedBox(height: 8),
                            Text(
                              p.description,
                              style: AppTextStyles.bodySm.copyWith(height: 1.6),
                            ),
                            const SizedBox(height: 18),
                            Text('Commodités', style: AppTextStyles.h4),
                            const SizedBox(height: 10),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: p.amenities
                                  .map(
                                    (a) => Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 8,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColors.tertiary,
                                        borderRadius: BorderRadius.circular(
                                          100,
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Iconify(
                                            Lucide.check,
                                            size: 12,
                                            color: AppColors.primaryDark,
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                            a,
                                            style: AppTextStyles.caption
                                                .copyWith(
                                                  color: AppColors.primaryDark,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                            const SizedBox(height: 18),
                            Text('Localisation', style: AppTextStyles.h4),
                            const SizedBox(height: 10),
                            Container(
                              height: 120,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                gradient: const LinearGradient(
                                  colors: [
                                    AppColors.tertiary,
                                    AppColors.secondary,
                                  ],
                                ),
                              ),
                              alignment: Alignment.center,
                              child: const Iconify(
                                Lucide.map_pin,
                                size: 30,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Container(
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                color: AppColors.background,
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(14),
                                    child: Image.network(
                                      p.ownerAvatar,
                                      width: 46,
                                      height: 46,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          p.ownerName,
                                          style: AppTextStyles.bodyMd.copyWith(
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        Text(
                                          p.ownerType,
                                          style: AppTextStyles.caption,
                                        ),
                                      ],
                                    ),
                                  ),
                                  _circle(
                                    AppColors.success,
                                    Lucide.message_circle,
                                  ),
                                  const SizedBox(width: 8),
                                  _circle(AppColors.primary, Lucide.phone_call),
                                ],
                              ),
                            ),
                            const SizedBox(height: 100),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                DomusAppBar(
                  transparentOverImage: true,
                  actions: [
                    CircleIcon(icon: Lucide.share_2),
                    const SizedBox(width: 8),
                    CircleIcon(
                      icon: Lucide.heart,
                      onTap: vm.toggleFavorite,
                      color: p.isFavorite ? AppColors.favorite : null,
                    ),
                  ],
                ),
              ],
            ),
            bottomNavigationBar: Container(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 26),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: AppColors.border)),
              ),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Prix', style: AppTextStyles.caption),
                      Text(p.price, style: AppTextStyles.priceLg),
                    ],
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: PrimaryButton(
                      title: 'Réserver une visite',
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _pill(String icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.55),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Iconify(icon, size: 13, color: Colors.white),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11.5,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _stat(String icon, String label) {
    return Column(
      children: [
        Iconify(icon, size: 17, color: AppColors.primary),
        const SizedBox(height: 4),
        Text(label, style: AppTextStyles.caption),
      ],
    );
  }

  Widget _circle(Color color, String icon) {
    return Container(
      width: 38,
      height: 38,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      child: Iconify(icon, size: 16, color: Colors.white),
    );
  }
}
