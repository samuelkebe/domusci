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

  @override
  Widget build(BuildContext context) {
    const accentDark = Color(0xFF1E2022);
    const inactive = Color(0xFF9AA39A);
    const pillColor = Color(0xFFEAF5DE);
    const fabGradient = [Color(0xFF7BC96F), Color(0xFF3E8E41)];
    
    final navItems = [
      {'icon': Icons.home_outlined, 'iconFilled': Icons.home_rounded, 'label': 'Accueil'},
      {'icon': Icons.settings_outlined, 'iconFilled': Icons.settings_rounded, 'label': 'Paramètres'},
    ];

    return SafeArea( 
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
        child: SizedBox(
          height: 80,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.bottomCenter,
            children: [
              Positioned.fill(
                child: Container(
                  height: 64,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.95),
                    borderRadius: BorderRadius.circular(32),
                    boxShadow: [
                      BoxShadow(
                        color: accentDark.withOpacity(0.08),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(navItems.length, (index) {
                      final isSelected = widget.currentIndex == index;
                      final item = navItems[index];
                      
                      return Expanded(
                        child: GestureDetector(
                          onTap: () {
                            if (widget.currentIndex != index) {
                              HapticFeedback.selectionClick();
                              widget.onTap(index);
                            }
                          },
                          child: Container(
                            height: double.infinity,
                            alignment: Alignment.center,
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 250),
                              padding: EdgeInsets.symmetric(
                                horizontal: isSelected ? 20 : 0,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: isSelected ? pillColor : Colors.transparent,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    isSelected ? item['iconFilled'] as IconData : item['icon'] as IconData,
                                    size: 24,
                                    color: isSelected ? accentDark : inactive,
                                  ),
                                  if (isSelected) ...[
                                    const SizedBox(width: 8),
                                    Text(
                                      item['label'] as String,
                                      style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: accentDark,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
              Positioned(
                bottom: 32,
                child: GestureDetector(
                  onTapDown: (_) => setState(() => _publishPressed = true),
                  onTapUp: (_) => setState(() => _publishPressed = false),
                  onTapCancel: () => setState(() => _publishPressed = false),
                  onTap: () {
                    HapticFeedback.mediumImpact();
                    widget.onPublishTap();
                  },
                  child: AnimatedScale(
                    scale: _publishPressed ? 0.92 : 1.0,
                    duration: const Duration(milliseconds: 120),
                    curve: Curves.easeOut,
                    child: Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: fabGradient,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: fabGradient[1].withOpacity(0.4),
                            blurRadius: 16,
                            offset: const Offset(0, 6),
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
}