// import 'package:flutter/material.dart';
// import 'package:iconify_flutter/iconify_flutter.dart';
// import 'package:provider/provider.dart';
// import '../../ressources/app_colors.dart';
// import '../../ressources/app_text_styles.dart';
// import '../../views-models/notifications_view_model.dart';
//
// /// Vue — Notifications (nouvelle annonce, baisse de prix, message, visite…).
// class NotificationsView extends StatelessWidget {
//   const NotificationsView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (_) => NotificationsViewModel()..load(),
//       child: Consumer<NotificationsViewModel>(
//         builder: (context, vm, _) {
//           return Scaffold(
//             body: SafeArea(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         const Text('Notifications',),
//                         TextButton(
//                           onPressed: vm.markAllRead,
//                           child: Text('Tout marquer lu',
//                               style: AppTextStyles.bodySm.copyWith(color: AppColors.primary, fontWeight: FontWeight.w700)),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Expanded(
//                     child: vm.isLoading
//                         ? const Center(child: CircularProgressIndicator(color: AppColors.primary))
//                         : ListView.separated(
//                             padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
//                             itemCount: vm.notifications.length,
//                             separatorBuilder: (_, __) => const SizedBox(height: 10),
//                             itemBuilder: (context, i) {
//                               final n = vm.notifications[i];
//                               return Container(
//                                 padding: const EdgeInsets.all(14),
//                                 decoration: BoxDecoration(
//                                   color: n.unread ? Colors.white : Colors.transparent,
//                                   borderRadius: BorderRadius.circular(16),
//                                   border: Border.all(color: n.unread ? AppColors.border : Colors.transparent),
//                                 ),
//                                 child: Row(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Container(
//                                       width: 40,
//                                       height: 40,
//                                       decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(12)),
//                                       child: Iconify(n.icon, size: 18, color: AppColors.primary),
//                                     ),
//                                     const SizedBox(width: 12),
//                                     Expanded(
//                                       child: Column(
//                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                         children: [
//                                           Text(n.title, style: AppTextStyles.bodyMd.copyWith(fontWeight: FontWeight.w700)),
//                                           const SizedBox(height: 2),
//                                           Text(n.description, style: AppTextStyles.bodySm),
//                                           const SizedBox(height: 6),
//                                           Text(n.time, style: AppTextStyles.caption),
//                                         ],
//                                       ),
//                                     ),
//                                     if (n.unread)
//                                       Container(
//                                         margin: const EdgeInsets.only(top: 4),
//                                         width: 8,
//                                         height: 8,
//                                         decoration: const BoxDecoration(color: AppColors.favorite, shape: BoxShape.circle),
//                                       ),
//                                   ],
//                                 ),
//                               );
//                             },
//                           ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
