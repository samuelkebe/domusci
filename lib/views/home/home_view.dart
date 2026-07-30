import 'package:domusci/models/bien_immobilier_model.dart';
import 'package:domusci/views/home/detail_bien_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_skeleton_ui/flutter_skeleton_ui.dart';

import '../../components/card_bien_immobilier.dart';
import '../../models/enum/statut_bien_immobilier.dart';
import '../../resources/color.dart';
import '../../views-models/home_view_model.dart';
import '../profile/profile_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final viewModel = Provider.of<HomeViewModel>(context, listen: false);
      viewModel.getBienImmobiliers();
      viewModel.getTypeBienImmobiliers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<HomeViewModel>(
        builder: (context, value, child) {
          return Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFFEAF5DE),
                      Color(0xFFF7FAF2),
                    ],
                  ),
                ),
                child: SafeArea(
                  child: RefreshIndicator(
                    color: AppColors.black,
                    displacement: 40,
                    strokeWidth: 3,
                    onRefresh: () async {
                      await value.getBienImmobiliers();
                      value.getTypeBienImmobiliers();
                    },
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              InkWell(
                                onTap: () {},
                                child: Container(
                                  width: 48,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.03),
                                        blurRadius: 10,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Icon(
                                    Icons.menu,
                                    color: const Color(0xFF1E2022),
                                    size: 48 * 0.45,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Stack(
                                children: [
                                  Container(
                                    width: 48,
                                    height: 48,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.03),
                                          blurRadius: 10,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: Icon(
                                      Icons.notifications_none_outlined,
                                      color: const Color(0xFF1E2022),
                                      size: 48 * 0.45,
                                    ),
                                  ),
                                  Positioned(
                                    right: 12,
                                    top: 12,
                                    child: Container(
                                      width: 8,
                                      height: 8,
                                      decoration: const BoxDecoration(
                                        color: Colors.green,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 12),
                              InkWell(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                                      return ProfilView();
                                  },));
                                },
                                child: const CircleAvatar(
                                  radius: 24,
                                  backgroundImage: NetworkImage(
                                    'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=200&q=80',
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Conçu pour vous,',
                                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF1E2229),
                                        height: 1.2,
                                      ),
                                    ),
                                    Text(
                                      'Explorez les propriétés',
                                      style: Theme.of(context).textTheme.titleMedium
                                          ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xFF1E2229),
                                        height: 1.2,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  width: 48,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.03),
                                        blurRadius: 10,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Icon(
                                    CupertinoIcons.search,
                                    color: const Color(0xFF1E2022),
                                    size: 48 * 0.45,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            height: 50,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: value.typesBiens.length,
                              separatorBuilder: (_, _) => const SizedBox(width: 12),
                              itemBuilder: (context, index) {
                                if (index == 0) {
                                  final isSelected = value.selectedTypeBienImmobilier == null;
                                  return GestureDetector(
                                    onTap: () {
                                      value.filterBiensByType(null);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 24,
                                        vertical: 14,
                                      ),
                                      decoration: BoxDecoration(
                                        color: isSelected
                                            ? const Color(0xFFE1F57A)
                                            : Colors.white.withOpacity(0.6),
                                        borderRadius: BorderRadius.circular(30),
                                        border: Border.all(
                                          color: Colors.white.withOpacity(0.8),
                                        ),
                                      ),
                                      child: Text(
                                        "Tous",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xFF1E2022),
                                        ),
                                      ),
                                    ),
                                  );
                                }
                                final type = value.typesBiens[index - 1];
                                final isSelected = value.selectedTypeBienImmobilier == type;
                                return GestureDetector(
                                  onTap: () {
                                    if (value.selectedTypeBienImmobilier == type) {
                                      value.filterBiensByType(null);
                                    } else {
                                      value.filterBiensByType(type);
                                    }
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                      left: 6,
                                      right: 18,
                                      top: 6,
                                      bottom: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? const Color(0xFFE1F57A)
                                          : Colors.white.withOpacity(0.6),
                                      borderRadius: BorderRadius.circular(30),
                                      border: Border.all(
                                        color: Colors.white.withOpacity(0.8),
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        const SizedBox(width: 8),
                                        Text(
                                          type.libelle ?? "",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                            fontWeight: FontWeight.w500,
                                            color: const Color(0xFF1E2022),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 28),
                          Text(
                            'Recommandez pour vous',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1E2022),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Skeleton(
                            isLoading: value.isLoadingBienImmobiliers,
                            skeleton: SkeletonListView(),
                            child: RefreshIndicator(
                              color: AppColors.green3,
                              onRefresh: () async {
                                value.getBienImmobiliers();
                              },
                              child: value.filteredBienImmobiliers.isEmpty
                                  ? SizedBox(
                                height: MediaQuery.of(context).size.height * 0.4,
                                child: Center(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Image.asset(
                                        'assets/images/panier.png',
                                        width: 80,
                                        height: 100,
                                        errorBuilder: (context, error, stackTrace) {
                                          return Icon(
                                            Icons.house_outlined,
                                            size: 80,
                                            color: Colors.grey[400],
                                          );
                                        },
                                      ),
                                      const SizedBox(height: 16),
                                      Text(
                                        "Aucun bien immobilier trouvé",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.copyWith(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        "Vérifiez vos filtres ou revenez plus tard",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                          fontSize: 14,
                                          color: Colors.grey[400],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                                  : Column(
                                children: value.filteredBienImmobiliers.map((bienImmobilier) {
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 16),
                                    child: InkWell(
                                      onTap: () {
                                        value.setSelectedBienImmobilier(bienImmobilier);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => DetailBienView(
                                              bienImmobilier: bienImmobilier,
                                            ),
                                          ),
                                        );
                                      },
                                      child: CardBienImmobilier(
                                        bienImmobilier: bienImmobilier,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              // Bouton flottant "Besoin d'aide"
              Positioned(
                bottom: 24,
                right: 24,
                child: GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
                      isDismissible: true,
                      builder: (context) => Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                        ),
                        child: SafeArea(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: Container(
                                      width: 40,
                                      height: 4,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        borderRadius: BorderRadius.circular(2),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: AppColors.green3,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          Icons.help_outline,
                                          color: AppColors.black,
                                          size: 24,
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Text(
                                        "Centre d'aide",
                                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                          fontWeight: FontWeight.w700,
                                          color: const Color(0xFF1E2022),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 24),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    borderRadius: BorderRadius.circular(14),
                                    child: Container(
                                      padding: const EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                        color: Colors.grey[50],
                                        borderRadius: BorderRadius.circular(14),
                                        border: Border.all(color: Colors.grey[100]!),
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              color: AppColors.green3,
                                              borderRadius: BorderRadius.circular(12),
                                            ),
                                            child: Icon(CupertinoIcons.question_circle, color: AppColors.black, size: 20),
                                          ),
                                          const SizedBox(width: 16),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Signaler un incident",
                                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                                    fontWeight: FontWeight.w600,
                                                    color: const Color(0xFF1E2022),
                                                  ),
                                                ),
                                                Text(
                                                  "Réponse en moins de 5 minutes",
                                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                    color: Colors.grey[600],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Icon(
                                            Icons.chevron_right,
                                            color: Colors.grey[400],
                                            size: 20,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    borderRadius: BorderRadius.circular(14),
                                    child: Container(
                                      padding: const EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                        color: Colors.grey[50],
                                        borderRadius: BorderRadius.circular(14),
                                        border: Border.all(color: Colors.grey[100]!),
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              color: AppColors.green3,
                                              borderRadius: BorderRadius.circular(12),
                                            ),
                                            child: Icon(Icons.phone_outlined, color: AppColors.black, size: 20),
                                          ),
                                          const SizedBox(width: 16),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Appeler le support",
                                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                                    fontWeight: FontWeight.w600,
                                                    color: const Color(0xFF1E2022),
                                                  ),
                                                ),
                                                Text(
                                                  "+225 05 00 00 00 00",
                                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                    color: Colors.grey[600],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Icon(
                                            Icons.chevron_right,
                                            color: Colors.grey[400],
                                            size: 20,
                                          ),
                                        ], 
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                              
                                  InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    borderRadius: BorderRadius.circular(14),
                                    child: Container(
                                      padding: const EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                        color: Colors.grey[50],
                                        borderRadius: BorderRadius.circular(14),
                                        border: Border.all(color: Colors.grey[100]!),
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              color: AppColors.green3,
                                              borderRadius: BorderRadius.circular(12),
                                            ),
                                            child: Icon(Icons.help, color: AppColors.black, size: 20),
                                          ),
                                          const SizedBox(width: 16),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Foire aux questions",
                                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                                    fontWeight: FontWeight.w600,
                                                    color: const Color(0xFF1E2022),
                                                  ),
                                                ),
                                                // Text(
                                                //   "Trouvez des réponses rapidement",
                                                //   style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                //     color: Colors.grey[600],
                                                //   ),
                                                // ),
                                              ],
                                            ),
                                          ),
                                          Icon(
                                            Icons.chevron_right,
                                            color: Colors.grey[400],
                                            size: 20,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  SizedBox(
                                    width: double.infinity,
                                    child: TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      style: TextButton.styleFrom(
                                        backgroundColor: Colors.grey[50],
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                      ),
                                      child: Text(
                                        "Fermer",
                                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                          color: Colors.grey[600],
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                    decoration: BoxDecoration(
                     color: AppColors.green3,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.green3.withOpacity(0.4),
                          blurRadius: 20,
                          spreadRadius: 4,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.help_outline,
                          color: AppColors.black,
                          size: 22,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          "Besoin d'aide ?",
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),    );
  }
}
