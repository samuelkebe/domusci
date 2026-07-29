import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/lucide.dart';
import '../../../models/property.dart';
import '../../../ressources/app_colors.dart';
import '../../../ressources/app_spacing.dart';
import '../../../ressources/app_text_styles.dart';
import '../badges/domus_badge.dart';

enum PropertyCardVariant { wide, full, horizontal }

/// Carte immobilière premium — photo HD, badge, prix, quartier, stats, favori.
class PropertyCard extends StatelessWidget {
  final Property property;
  final VoidCallback? onTap;
  final VoidCallback? onFavoriteToggle;
  final PropertyCardVariant variant;

  const PropertyCard({
    super.key,
    required this.property,
    this.onTap,
    this.onFavoriteToggle,
    this.variant = PropertyCardVariant.wide,
  });

  @override
  Widget build(BuildContext context) {
    if (variant == PropertyCardVariant.horizontal) return _buildHorizontal();
    final width = variant == PropertyCardVariant.wide ? 250.0 : double.infinity;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.border),
          boxShadow: const [BoxShadow(color: AppColors.shadow, blurRadius: 24, offset: Offset(0, 10))],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Hero(
                  tag: 'property-${property.id}',
                  child: Image.network(
                    property.imageUrl,
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (c, e, s) => Container(
                      height: 150,
                      color: AppColors.tertiary,
                      child: const Iconify(Lucide.image, color: Colors.white54),
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  left: 10,
                  right: 10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DomusBadge(badge: property.badge),
                      _FavButton(active: property.isFavorite, onTap: onFavoriteToggle),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(property.price, style: AppTextStyles.priceMd),
                  const SizedBox(height: 3),
                  Text(property.title, maxLines: 1, overflow: TextOverflow.ellipsis, style: AppTextStyles.bodyMd),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Iconify(Lucide.map_pin, size: 12, color: AppColors.textSecondary),
                      const SizedBox(width: 3),
                      Expanded(
                        child: Text('${property.quartier} · ${property.surface}',
                            maxLines: 1, overflow: TextOverflow.ellipsis, style: AppTextStyles.bodySm),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Container(height: 1, color: AppColors.border),
                  const SizedBox(height: 8),
                  _StatsRow(property: property),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHorizontal() {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: AppColors.border),
        ),
        clipBehavior: Clip.antiAlias,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 112,
              height: 112,
              child: Stack(
                children: [
                  Image.network(property.imageUrl, width: 112, height: 112, fit: BoxFit.cover,
                      errorBuilder: (c, e, s) => Container(color: AppColors.tertiary)),
                  Positioned(top: 6, left: 6, child: DomusBadge(badge: property.badge)),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 10, 10, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: Text(property.price, style: AppTextStyles.priceMd.copyWith(fontSize: 14))),
                        _FavButton(active: property.isFavorite, onTap: onFavoriteToggle, small: true),
                      ],
                    ),
                    Text(property.title, maxLines: 1, overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.bodyMd.copyWith(fontSize: 12.5)),
                    const SizedBox(height: 3),
                    Row(
                      children: [
                        const Iconify(Lucide.map_pin, size: 11, color: AppColors.textSecondary),
                        const SizedBox(width: 3),
                        Expanded(
                          child: Text(property.quartier, maxLines: 1, overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.bodySm.copyWith(fontSize: 11.5)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    _StatsRow(property: property, compact: true),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatsRow extends StatelessWidget {
  final Property property;
  final bool compact;
  const _StatsRow({required this.property, this.compact = false});

  @override
  Widget build(BuildContext context) {
    final style = AppTextStyles.caption.copyWith(fontSize: compact ? 11 : 11.5);
    final items = <Widget>[];
    if (property.bedrooms != null) {
      items.add(_stat(Lucide.bed_double, '${property.bedrooms}', style));
      items.add(_stat(Lucide.bath, '${property.bathrooms}', style));
      if (property.hasParking) items.add(_stat(Lucide.car, '', style));
    } else {
      items.add(_stat(Lucide.map, 'Terrain', style));
    }
    items.add(_stat(Lucide.navigation, property.distance, style));

    return Wrap(spacing: 12, runSpacing: 4, children: items);
  }

  Widget _stat(String icon, String label, TextStyle style) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Iconify(icon, size: 13, color: AppColors.textSecondary),
        if (label.isNotEmpty) ...[const SizedBox(width: 3), Text(label, style: style)],
      ],
    );
  }
}

class _FavButton extends StatelessWidget {
  final bool active;
  final VoidCallback? onTap;
  final bool small;
  const _FavButton({required this.active, this.onTap, this.small = false});

  @override
  Widget build(BuildContext context) {
    final size = small ? 26.0 : 32.0;
    return GestureDetector(
      onTap: () {
        HapticFeedback.mediumImpact();
        onTap?.call();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: small ? AppColors.background : Colors.white.withOpacity(0.94),
          shape: BoxShape.circle,
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 3))],
        ),
        child: active
            ? Icon(Icons.favorite_rounded, size: small ? 13 : 16, color: AppColors.favorite)
            : Iconify(Lucide.heart, size: small ? 13 : 16, color: AppColors.textSecondary),
      ),
    );
  }
}
