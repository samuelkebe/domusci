import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/lucide.dart';
import '../../../ressources/app_colors.dart';
import '../../../ressources/app_text_styles.dart';

/// App bar minimaliste avec bouton retour circulaire — pour écrans secondaires.
class DomusAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? actions;
  final bool transparentOverImage;

  const DomusAppBar({super.key, this.title, this.actions, this.transparentOverImage = false});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Row(
          children: [
            _CircleIconButton(
              icon: Lucide.chevron_left,
              onTap: () => Navigator.of(context).maybePop(),
              transparent: transparentOverImage,
            ),
            if (title != null) ...[
              const SizedBox(width: 12),
              Expanded(child: Text(title!, style: AppTextStyles.h4)),
            ] else
              const Spacer(),
            if (actions != null) ...actions!,
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}

class _CircleIconButton extends StatelessWidget {
  final String icon;
  final VoidCallback onTap;
  final bool transparent;
  const _CircleIconButton({required this.icon, required this.onTap, this.transparent = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: transparent ? Colors.white.withOpacity(0.9) : Colors.white,
          shape: BoxShape.circle,
          border: transparent ? null : Border.all(color: AppColors.border),
          boxShadow: transparent
              ? const [BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 2))]
              : null,
        ),
        child: Iconify(icon, size: 18, color: AppColors.textPrimary),
      ),
    );
  }
}

/// Icône ronde générique — favori, partage, notifications sur une image.
class CircleIcon extends StatelessWidget {
  final String icon;
  final VoidCallback? onTap;
  final Color? color;
  final Color? background;
  const CircleIcon({super.key, required this.icon, this.onTap, this.color, this.background});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: background ?? Colors.white.withOpacity(0.92),
          shape: BoxShape.circle,
          boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 2))],
        ),
        child: Iconify(icon, size: 16, color: color ?? AppColors.textPrimary),
      ),
    );
  }
}
