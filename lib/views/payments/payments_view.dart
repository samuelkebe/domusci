// import 'package:flutter/material.dart';
// import 'package:iconify_flutter/iconify_flutter.dart';
// import 'package:iconify_flutter/icons/lucide.dart';
// import '../../ressources/app_colors.dart';
// import '../../ressources/app_spacing.dart';
// import '../../ressources/app_text_styles.dart';
// import '../widgets/app_bar/domus_app_bar.dart';
// import '../widgets/payment/payment_method_card.dart';
//
// /// Vue — Paiements : Orange Money, Wave, MTN, Moov, carte bancaire.
// class PaymentsView extends StatelessWidget {
//   const PaymentsView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: DomusAppBar(title: 'Paiements'),
//       body: ListView(
//         padding: const EdgeInsets.fromLTRB(20, 6, 20, 24),
//         children: [
//           Container(
//             padding: const EdgeInsets.all(20),
//             decoration: BoxDecoration(gradient: AppColors.primaryGradient, borderRadius: BorderRadius.circular(20)),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text('SOLDE DISPONIBLE', style: AppTextStyles.caption.copyWith(color: Colors.white70, letterSpacing: 1)),
//                 const SizedBox(height: 6),
//                 const Text('45 000 FCFA', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w800)),
//               ],
//             ),
//           ),
//           const SizedBox(height: AppSpacing.lg),
//           Text('Méthodes de paiement', style: AppTextStyles.h4),
//           const SizedBox(height: 12),
//           const PaymentMethodCard(name: 'Orange Money', subtitle: '•••• 4521', brandColor: Color(0xFFFF7900), ),
//           const SizedBox(height: 10),
//           const PaymentMethodCard(name: 'Wave', subtitle: '•••• 8890', brandColor: Color(0xFF1DC8E0),),
//           const SizedBox(height: 10),
//           const PaymentMethodCard(name: 'MTN Mobile Money', subtitle: '•••• 2214', brandColor: Color(0xFFFFCB05),),
//           const SizedBox(height: 10),
//           const PaymentMethodCard(name: 'Moov Money', subtitle: '•••• 7723', brandColor: Color(0xFF0072CE),),
//           const SizedBox(height: 10),
//           const PaymentMethodCard(name: 'Carte bancaire', subtitle: 'Visa •••• 0099', brandColor: AppColors.primary,),
//         ],
//       ),
//     );
//   }
// }

