// import 'package:flutter/material.dart';
// import 'package:iconify_flutter/iconify_flutter.dart';
// import 'package:iconify_flutter/icons/lucide.dart';
// import '../../ressources/app_colors.dart';
// import '../../ressources/app_text_styles.dart';
// import '../widgets/app_bar/domus_app_bar.dart';
//
// /// Vue — Historique : visites, locations, achats, paiements.
// class HistoryView extends StatelessWidget {
//   const HistoryView({super.key});
//
//   static const _items = [
//     (title: 'Visite — Villa Riviera Golf', date: 'Sam. 25 juil. · 10:00', status: 'Confirmée', color: AppColors.success),
//     (title: 'Visite — Appartement Cocody', date: 'Mar. 21 juil. · 15:30', status: 'Terminée', color: AppColors.textSecondary),
//     (title: 'Visite — Duplex Angré', date: 'Ven. 10 juil. · 09:00', status: 'Annulée', color: AppColors.error),
//     (title: 'Visite — Studio Deux-Plateaux', date: 'Lun. 6 juil. · 17:00', status: 'Terminée', color: AppColors.textSecondary),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: DomusAppBar(title: 'Historique'),
//       body: ListView.separated(
//         padding: const EdgeInsets.fromLTRB(20, 6, 20, 24),
//         itemCount: _items.length,
//         separatorBuilder: (_, __) => const SizedBox(height: 10),
//         itemBuilder: (context, i) {
//           final h = _items[i];
//           return Container(
//             padding: const EdgeInsets.all(14),
//             decoration: BoxDecoration(color: Colors.white, border: Border.all(color: AppColors.border), borderRadius: BorderRadius.circular(16)),
//             child: Row(
//               children: [
//                 Container(
//                   width: 40,
//                   height: 40,
//                   decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(12)),
//                   child: const Iconify(Lucide.history, size: 17, color: AppColors.primary),
//                 ),
//                 const SizedBox(width: 12),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(h.title, style: AppTextStyles.bodyMd.copyWith(fontWeight: FontWeight.w700)),
//                       Text(h.date, style: AppTextStyles.caption),
//                     ],
//                   ),
//                 ),
//                 Text(h.status, style: AppTextStyles.caption.copyWith(color: h.color, fontWeight: FontWeight.w700)),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

