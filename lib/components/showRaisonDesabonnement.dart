// import 'package:myshopsuperapp/views_models/gestion_marchands/marchand_viewmodel.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// void showRaisonDesabonnementBottomSheet(BuildContext context) {
//   showModalBottomSheet(
//     isDismissible: false,
//     context: context,
//     isScrollControlled: true,
//     showDragHandle: true,
//     backgroundColor: Colors.white,
//     builder: (context) {
//       return Consumer<MarchandViewModel>(
//         builder: (context, marchandVm, _) {
//           final selectedRaison = marchandVm.selectedRaisonDesabonnement;
//           List<RaisonDesabonnement> filteredRaisonDesabo = List.from(marchandVm.pointsVentes);
//
//           return StatefulBuilder(
//             builder: (context, setState) {
//               return SafeArea(
//                 child: FractionallySizedBox(
//                   heightFactor: 0.7,
//                   child: Column(
//                     children: [
//                       // En-tête avec recherche
//                       Padding(
//                         padding: const EdgeInsets.all(16),
//                         child: Column(
//                           children: [
//                             const SizedBox(height: 12),
//                             Text(
//                               'Sélectionnez un point de vente',
//                               style: Theme.of(context)
//                                   .textTheme
//                                   .bodyMedium
//                                   ?.copyWith(fontWeight: FontWeight.bold),
//                             ),
//                             const SizedBox(height: 12),
//                             Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: TextField(
//                                 style: Theme.of(context).textTheme.bodyMedium,
//                                 decoration: InputDecoration(
//                                   hintText: "Rechercher un point de vente",
//                                   hintStyle: Theme.of(context).textTheme.bodyMedium,
//                                   labelStyle: Theme.of(context).textTheme.bodyMedium,
//                                   prefixIcon: const Icon(Icons.search),
//                                   border: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(15),
//                                   ),
//
//                                 ),
//                                 onChanged: (query) {
//                                   setState(() {
//                                     filteredPointsVentes = marchandVm.pointsVentes
//                                         .where((pv) => pv.nomAgence != null &&
//                                         pv.nomAgence!
//                                             .toLowerCase()
//                                             .contains(query.toLowerCase()))
//                                         .toList();
//                                   });
//                                 },
//                               ),
//                             ),
//                             const SizedBox(height: 16),
//                           ],
//                         ),
//                       ),
//
//                       // Liste scrollable
//                       Expanded(
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 16),
//                           child: filteredPointsVentes.isEmpty
//                               ? Center(
//                             child: Text(
//                               'Aucun point de vente trouvé',
//                               style:
//                               Theme.of(context).textTheme.bodyMedium,
//                             ),
//                           )
//                               : ListView.separated(
//                             itemCount: filteredPointsVentes.length,
//                             itemBuilder: (context, index) {
//                               final pv = filteredPointsVentes[index];
//                               final isSelected = pv == selectedPointVente;
//
//                               return Card(
//                                 color: Colors.grey.shade100,
//                                 elevation: 0,
//                                 margin: EdgeInsets.zero,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(8),
//                                   side: isSelected
//                                       ? BorderSide(
//                                     color: AppColors.gimpPayBlue100,
//                                     width: 0.5,
//                                   )
//                                       : BorderSide.none,
//                                 ),
//                                 child: ListTile(
//                                   contentPadding: const EdgeInsets.symmetric(
//                                     horizontal: 16,
//                                     vertical: 12,
//                                   ),
//                                   leading: Container(
//                                     width: 40,
//                                     height: 40,
//                                     decoration: BoxDecoration(
//                                       color: Theme.of(
//                                         context,
//                                       ).primaryColor.withOpacity(0.1),
//                                       shape: BoxShape.circle,
//                                     ),
//                                     child: Icon(
//                                       Icons.store,
//                                       color: AppColors.gimpPayBlue100,
//                                       size: 20,
//                                     ),
//                                   ),
//                                   title: Text(
//                                     pv.nomAgence ?? '',
//                                     style: Theme.of(context)
//                                         .textTheme
//                                         .bodyMedium
//                                         ?.copyWith(
//                                       fontWeight: isSelected
//                                           ? FontWeight.bold
//                                           : FontWeight.normal,
//                                     ),
//                                     overflow: TextOverflow.ellipsis,
//                                   ),
//                                   trailing: isSelected
//                                       ? Icon(
//                                     Icons.check_circle,
//                                     color: AppColors.gimpPayBlue100,
//                                   )
//                                       : null,
//                                   onTap: () {
//                                     marchandVm.setSelectedPointVente(pv);
//                                     Navigator.pop(context);
//                                   },
//                                 ),
//                               );
//                             },
//                             separatorBuilder: (context, index) =>
//                             const SizedBox(height: 8),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       );
//     },
//   );
// }
