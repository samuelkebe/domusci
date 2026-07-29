import 'package:flutter/material.dart';
import '../../../ressources/app_colors.dart';
import '../../../ressources/app_spacing.dart';

/// Skeleton loader avec effet shimmer discret — utilisé pendant le chargement des cartes.
class SkeletonBox extends StatefulWidget {
  final double? width;
  final double height;
  final double radius;

  const SkeletonBox({super.key, this.width, required this.height, this.radius = AppSpacing.radiusSm});

  @override
  State<SkeletonBox> createState() => _SkeletonBoxState();
}

class _SkeletonBoxState extends State<SkeletonBox> with SingleTickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: const Duration(milliseconds: 1400))..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final t = _controller.value;
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.radius),
            gradient: LinearGradient(
              begin: Alignment(-1 + t * 3, 0),
              end: Alignment(0 + t * 3, 0),
              colors: const [AppColors.tertiary, AppColors.background, AppColors.tertiary],
            ),
          ),
        );
      },
    );
  }
}

/// Squelette d'une carte immobilière — placeholder pendant le chargement.
class PropertyCardSkeleton extends StatelessWidget {
  final double width;
  const PropertyCardSkeleton({super.key, this.width = 250,  bool? fullWidth});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SkeletonBox(height: 150, radius: 0),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SkeletonBox(width: width * 0.5, height: 16),
                  const SizedBox(height: 8),
                  SkeletonBox(width: width * 0.75, height: 12),
                  const SizedBox(height: 8),
                  SkeletonBox(width: width * 0.4, height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
