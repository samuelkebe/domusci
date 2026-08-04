import 'package:flutter/material.dart';

class SelectableChip extends StatelessWidget {
  final String label;
  final IconData? icon;
  final bool selected;
  final VoidCallback onTap;

  const SelectableChip({
    super.key,
    required this.label,
    this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        curve: Curves.easeOut,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFFE1F57A) : Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: selected ? null : Border.all(color: const Color(0xFFE5E7EB)),
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: const Color(0xFFE1F57A).withOpacity(0.45),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 16, color: const Color(0xFF1E2022)),
              const SizedBox(width: 7),
            ],
            Text(
              label,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF1E2022)),
            ),
          ],
        ),
      ),
    );
  }
}

