import 'package:flutter/material.dart';

class MapPlaceholder extends StatelessWidget {
  final bool hasPin;
  const MapPlaceholder({super.key, required this.hasPin});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: [Colors.grey[100]!, Colors.grey[50]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      alignment: Alignment.center,
      child: hasPin
          ? Container(
              width: 34,
              height: 34,
              decoration: const BoxDecoration(
                color: Color(0xFF6FA83A),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.location_on_rounded, color: Colors.white, size: 18),
            )
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.map_rounded, size: 26, color: Colors.grey[400]),
                const SizedBox(height: 6),
                Text('Aperçu carte', style: TextStyle(fontSize: 11.5, color: Colors.grey[400], fontWeight: FontWeight.w600)),
              ],
            ),
    );
  }
}

