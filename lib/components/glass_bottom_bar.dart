import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GlassBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final VoidCallback onPublishTap;

  const GlassBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.onPublishTap,
  });

  static const _accentDark = Color(0xFF1E2022);
  static const _inactive = Color(0xFF9AA39A);
  static const _fabGradient = [Color(0xFF6FA83A), Color(0xFF4A7A2A)];

  static const _navItems = [
    (icon: Icons.home_outlined, iconFilled: Icons.home_rounded, label: 'Accueil'),
    (icon: Icons.settings_outlined, iconFilled: Icons.settings_rounded, label: 'Paramètres'),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.grey[100]!)),
        ),
        child: Row(
          children: [
            Expanded(child: _NavItem(item: _navItems[0], index: 0, currentIndex: currentIndex, onTap: onTap)),
            const SizedBox(width: 20),
            _PublishButton(onTap: onPublishTap),
            const SizedBox(width: 20),
            Expanded(child: _NavItem(item: _navItems[1], index: 1, currentIndex: currentIndex, onTap: onTap)),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final ({IconData icon, IconData iconFilled, String label}) item;
  final int index;
  final int currentIndex;
  final ValueChanged<int> onTap;

  const _NavItem({required this.item, required this.index, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isSelected = currentIndex == index;
    final color = isSelected ? GlassBottomNavBar._accentDark : GlassBottomNavBar._inactive;

    return GestureDetector(
      onTap: () {
        if (currentIndex != index) {
          HapticFeedback.selectionClick();
          onTap(index);
        }
      },
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(isSelected ? item.iconFilled : item.icon, size: 24, color: color),
            const SizedBox(height: 4),
            Text(
              item.label,
              style: TextStyle(fontSize: 11, fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500, color: color),
            ),
          ],
        ),
      ),
    );
  }
}

class _PublishButton extends StatelessWidget {
  final VoidCallback onTap;
  const _PublishButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          HapticFeedback.mediumImpact();
          onTap();
        },
        child: Ink(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: GlassBottomNavBar._fabGradient,
            ),
            boxShadow: [
              BoxShadow(
                color: GlassBottomNavBar._fabGradient[1].withOpacity(0.3),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Icon(Icons.add_rounded, color: Colors.white, size: 28),
        ),
      ),
    );
  }
}