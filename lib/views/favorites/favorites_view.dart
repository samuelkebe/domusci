// import 'package:flutter/material.dart';
// import 'package:iconify_flutter/iconify_flutter.dart';
// import 'package:iconify_flutter/icons/lucide.dart';
// import 'package:provider/provider.dart';
// import '../../ressources/app_spacing.dart';
// import '../../ressources/app_text_styles.dart';
// import '../../views-models/favorites_view_model.dart';
// import '../property/property_detail_view.dart';
// import '../widgets/cards/property_card.dart';
// import '../widgets/loaders/skeleton_loader.dart';
// import '../widgets/states/empty_state.dart';
//
// /// Vue — Favoris : biens sauvegardés, comparaison, tri.
// class FavoritesView extends StatelessWidget {
//   const FavoritesView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final vm = context.watch<FavoritesViewModel>();
//     return SafeArea(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text('Mes favoris', style: AppTextStyles.h1),
//                 const SizedBox(height: 4),
//                 Text('${vm.favorites.length} biens sauvegardés', style: AppTextStyles.bodySm),
//               ],
//             ),
//           ),
//           const SizedBox(height: AppSpacing.md),
//           Expanded(
//             child: vm.isLoading
//                 ? ListView.separated(
//                     padding: const EdgeInsets.symmetric(horizontal: 20),
//                     itemCount: 3,
//                     separatorBuilder: (_, __) => const SizedBox(height: 14),
//                     itemBuilder: (_, __) => const PropertyCardSkeleton(width: double.infinity),
//                   )
//                 : vm.isEmpty
//                     ? const Center(
//                         child: EmptyState(
//                           title: 'Aucun favori pour le moment',
//                           description: 'Enregistrez les biens qui vous intéressent pour les retrouver ici.',
//                         ),
//                       )
//                     : ListView.separated(
//                         padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
//                         itemCount: vm.favorites.length,
//                         separatorBuilder: (_, __) => const SizedBox(height: 14),
//                         itemBuilder: (context, i) {
//                           final p = vm.favorites[i];
//                           return PropertyCard(
//                             property: p,
//                             variant: PropertyCardVariant.full,
//                             onFavoriteToggle: () => vm.remove(p),
//                             onTap: () => Navigator.of(context)
//                                 .push(MaterialPageRoute(builder: (_) => PropertyDetailView(propertyId: p.id))),
//                           );
//                         },
//                       ),
//           ),
//         ],
//       ),
//     );
//   }
// }

