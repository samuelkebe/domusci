// import 'package:flutter/material.dart';
// import 'package:iconify_flutter/iconify_flutter.dart';
// import 'package:iconify_flutter/icons/lucide.dart';
// import 'package:provider/provider.dart';
// import '../../ressources/app_colors.dart';
// import '../../ressources/app_spacing.dart';
// import '../../ressources/app_text_styles.dart';
// import '../../views-models/listings_view_model.dart';
// import '../widgets/app_bar/domus_app_bar.dart';
// import '../widgets/badges/domus_badge.dart';
//
// /// Vue — Mes annonces : vues, favoris, contacts ; modifier / supprimer / renouveler.
// class ListingsView extends StatelessWidget {
//   const ListingsView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (_) => ListingsViewModel()..load(),
//       child: Consumer<ListingsViewModel>(
//         builder: (context, vm, _) {
//           return Scaffold(
//             appBar: DomusAppBar(title: 'Mes annonces'),
//             body: vm.isLoading
//                 ? const Center(child: CircularProgressIndicator(color: AppColors.primary))
//                 : ListView.separated(
//                     padding: const EdgeInsets.fromLTRB(20, 6, 20, 24),
//                     itemCount: vm.listings.length,
//                     separatorBuilder: (_, __) => const SizedBox(height: 14),
//                     itemBuilder: (context, i) {
//                       final p = vm.listings[i];
//                       final active = i != 2;
//                       return Container(
//                         decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: AppColors.border)),
//                         clipBehavior: Clip.antiAlias,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Stack(children: [
//                               Image.network(p.imageUrl, height: 130, width: double.infinity, fit: BoxFit.cover),
//                               Positioned(
//                                 top: 10,
//                                 left: 10,
//                                 right: 10,
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     DomusBadge(badge: p.badge),
//                                     StatusPill(label: active ? 'Active' : 'En attente', color: active ? AppColors.success : AppColors.warning),
//                                   ],
//                                 ),
//                               ),
//                             ]),
//                             Padding(
//                               padding: const EdgeInsets.all(14),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(p.price, style: AppTextStyles.priceMd),
//                                   Text(p.title, style: AppTextStyles.bodyMd),
//                                   const SizedBox(height: 8),
//                                   Row(
//                                     children: [
//                                       _statChip(Lucide.eye, '${120 + i * 34} vues'),
//                                       const SizedBox(width: 14),
//                                       _statChip(Lucide.heart, '${8 + i * 3}'),
//                                       const SizedBox(width: 14),
//                                       _statChip(Lucide.message_circle, '${4 + i}'),
//                                     ],
//                                   ),
//                                   const SizedBox(height: AppSpacing.md),
//                                   Row(
//                                     children: [
//                                       Expanded(child: _actionChip(Lucide.pencil, 'Modifier')),
//                                       const SizedBox(width: 8),
//                                       Expanded(child: _actionChip(Lucide.refresh_cw, 'Renouveler', onTap: () => vm.renew(p))),
//                                       const SizedBox(width: 8),
//                                       _iconAction(Lucide.trash_2, AppColors.error, () => vm.remove(p)),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                   ),
//           );
//         },
//       ),
//     );
//   }
//
//   Widget _statChip(String icon, String label) {
//     return Row(mainAxisSize: MainAxisSize.min, children: [
//       Iconify(icon, size: 13, color: AppColors.textSecondary),
//       const SizedBox(width: 4),
//       Text(label, style: AppTextStyles.caption),
//     ]);
//   }
//
//   Widget _actionChip(String icon, String label, {VoidCallback? onTap}) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         padding: const EdgeInsets.symmetric(vertical: 9),
//         decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(12)),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Iconify(icon, size: 13, color: AppColors.primary),
//             const SizedBox(width: 5),
//             Text(label, style: AppTextStyles.caption.copyWith(color: AppColors.primary, fontWeight: FontWeight.w700)),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _iconAction(String icon, Color color, VoidCallback onTap) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         width: 38,
//         height: 38,
//         decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
//         child: Iconify(icon, size: 15, color: color),
//       ),
//     );
//   }
// }

