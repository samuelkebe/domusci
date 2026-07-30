import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GlassBottomNavBar extends StatefulWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final VoidCallback onPublishTap;

  const GlassBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.onPublishTap,
  });

  @override
  State<GlassBottomNavBar> createState() => _GlassBottomNavBarState();
}

class _GlassBottomNavBarState extends State<GlassBottomNavBar> {
  bool _publishPressed = false;

  static const _accentDark = Color(0xFF1E2022);
  static const _inactive = Color(0xFF9AA39A);
  static const _pillColor = Color(0xFFEAF5DE);
  static const List<Color> _fabGradient = [
    Color(0xFF7BC96F),
    Color(0xFF3E8E41),
  ];

  static const List _items = [
    [Icons.home_outlined, Icons.home_rounded, ''],
    [Icons.settings_outlined, Icons.settings_rounded, ''],
  ];

  void _handleTap(int index) {
    if (index == widget.currentIndex) return;
    HapticFeedback.selectionClick();
    widget.onTap(index);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
        child: SizedBox(
          height: 82,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                height: 68,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(34),
                  border: Border.all(color: Colors.white, width: 1),
                  boxShadow: [
                    BoxShadow(
                      color: _accentDark.withOpacity(0.08),
                      blurRadius: 24,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(34),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildNavItem(0),
                      const SizedBox(width: 50),
                      _buildNavItem(1),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 40,
                child: GestureDetector(
                  onTapDown: (_) => setState(() => _publishPressed = true),
                  onTapUp: (_) => setState(() => _publishPressed = false),
                  onTapCancel: () => setState(() => _publishPressed = false),
                  onTap: () {
                    HapticFeedback.mediumImpact();
                    widget.onPublishTap();
                  },
                  child: AnimatedScale(
                    scale: _publishPressed ? 0.9 : 1.0,
                    duration: const Duration(milliseconds: 120),
                    curve: Curves.easeOut,
                    child: Container(
                      width: 58,
                      height: 58,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: _fabGradient,
                        ),
                        border: Border.all(color: Colors.white, width: 3),
                        boxShadow: [
                          BoxShadow(
                            color: _fabGradient.last.withOpacity(0.45),
                            blurRadius: 18,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.add_rounded,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index) {
    final selected = widget.currentIndex == index;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => _handleTap(index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 280),
          curve: Curves.easeOutCubic,
          padding: EdgeInsets.symmetric(
            horizontal: selected ? 14 : 8,
            vertical: 10,
          ),
          decoration: BoxDecoration(
            color: selected ? _pillColor : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                selected ? _items[index][1] as IconData : _items[index][0] as IconData,
                size: 22,
                color: selected ? _accentDark : _inactive,
              ),
              AnimatedSize(
                duration: const Duration(milliseconds: 220),
                curve: Curves.easeOutCubic,
                child: selected
                    ? Padding(
                  padding: const EdgeInsets.only(left: 6),
                  child: Text(
                    _items[index][2] as String,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: _accentDark,
                    ),
                  ),
                )
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}