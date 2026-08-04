import 'package:pisso/models/bien_immobilier_model.dart';
import 'package:pisso/views/home/detail_bien_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_skeleton_ui/flutter_skeleton_ui.dart';

import '../../components/card_bien_immobilier.dart';
import '../../models/enum/statut_bien_immobilier.dart';
import '../../resources/color.dart';
import '../../views-models/home_view_model.dart';
import '../menu/menu_view.dart';
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
      drawer: Drawer(
        child: MenuView(),
      ),
      body: Consumer<HomeViewModel>(
        builder: (context, value, child) {
          return Stack(
            children: [
              Positioned.fill(
                child: Container(
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
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Scaffold.of(context).openDrawer();
                                  },
                                  borderRadius: BorderRadius.circular(24),
                                  child: Container(
                                    width: 46,
                                    height: 46,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.05),
                                          blurRadius: 16,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: Icon(
                                      Icons.menu,
                                      color: const Color(0xFF1E2022),
                                      size: 46 * 0.42,
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    InkWell(
                                      onTap: () {},
                                      borderRadius: BorderRadius.circular(24),
                                      child: Container(
                                        width: 46,
                                        height: 46,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(0.05),
                                              blurRadius: 16,
                                              offset: const Offset(0, 4),
                                            ),
                                          ],
                                        ),
                                        child: Icon(
                                          Icons.notifications_none_outlined,
                                          color: const Color(0xFF1E2022),
                                          size: 46 * 0.42,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      right: 10,
                                      top: 10,
                                      child: Container(
                                        width: 9,
                                        height: 9,
                                        decoration: BoxDecoration(
                                          color: Colors.green,
                                          shape: BoxShape.circle,
                                          border: Border.all(color: Colors.white, width: 2),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 14),
                                InkWell(
                                  borderRadius: BorderRadius.circular(28),
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                                      return ProfilView();
                                    },));
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(2.5),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.06),
                                          blurRadius: 12,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: const CircleAvatar(
                                      radius: 21.5,
                                      backgroundImage: NetworkImage(
                                        'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=200&q=80',
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 28),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Conçu pour vous,',
                                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                          fontWeight: FontWeight.w500,
                                          color: const Color(0xFF6B7280),
                                          height: 1.25,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        'Explorez les propriétés',
                                        style: Theme.of(context).textTheme.titleLarge
                                            ?.copyWith(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 24,
                                          color: const Color(0xFF1E2229),
                                          height: 1.2,
                                          letterSpacing: -0.3,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 12),
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
                                          color: Colors.black.withOpacity(0.05),
                                          blurRadius: 16,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: Icon(
                                      CupertinoIcons.search,
                                      color: const Color(0xFF1E2022),
                                      size: 48 * 0.42,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),
                            SizedBox(
                              height: 48,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemCount: value.typesBiens.length,
                                separatorBuilder: (_, _) => const SizedBox(width: 10),
                                itemBuilder: (context, index) {
                                  if (index == 0) {
                                    final isSelected = value.selectedTypeBienImmobilier == null;
                                    return GestureDetector(
                                      onTap: () {
                                        value.filterBiensByType(null);
                                      },
                                      child: AnimatedContainer(
                                        duration: const Duration(milliseconds: 180),
                                        curve: Curves.easeOut,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 22,
                                          vertical: 12,
                                        ),
                                        decoration: BoxDecoration(
                                          color: isSelected
                                              ? const Color(0xFFE1F57A)
                                              : Colors.white,
                                          borderRadius: BorderRadius.circular(30),
                                          border: isSelected
                                              ? null
                                              : Border.all(color: const Color(0xFFE5E7EB)),
                                          boxShadow: isSelected
                                              ? [
                                            BoxShadow(
                                              color: const Color(0xFFE1F57A).withOpacity(0.45),
                                              blurRadius: 14,
                                              offset: const Offset(0, 4),
                                            ),
                                          ]
                                              : [],
                                        ),
                                        alignment: Alignment.center,
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
                                    child: AnimatedContainer(
                                      duration: const Duration(milliseconds: 180),
                                      curve: Curves.easeOut,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 22,
                                        vertical: 12,
                                      ),
                                      decoration: BoxDecoration(
                                        color: isSelected
                                            ? const Color(0xFFE1F57A)
                                            : Colors.white,
                                        borderRadius: BorderRadius.circular(30),
                                        border: isSelected
                                            ? null
                                            : Border.all(color: const Color(0xFFE5E7EB)),
                                        boxShadow: isSelected
                                            ? [
                                          BoxShadow(
                                            color: const Color(0xFFE1F57A).withOpacity(0.45),
                                            blurRadius: 14,
                                            offset: const Offset(0, 4),
                                          ),
                                        ]
                                            : [],
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        type.libelle ?? "",
                                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xFF1E2022),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 32),
                            Row(
                              children: [
                                Container(
                                  width: 5,
                                  height: 18,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFE1F57A),
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  'Recommandez pour vous',
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800,
                                    color: const Color(0xFF1E2022),
                                    letterSpacing: -0.2,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 18),
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
                                        Container(
                                          width: 96,
                                          height: 96,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black.withOpacity(0.04),
                                                blurRadius: 20,
                                                offset: const Offset(0, 6),
                                              ),
                                            ],
                                          ),
                                          alignment: Alignment.center,
                                          child: Image.asset(
                                            'assets/images/panier.png',
                                            width: 56,
                                            height: 70,
                                            errorBuilder: (context, error, stackTrace) {
                                              return Icon(
                                                Icons.house_outlined,
                                                size: 44,
                                                color: Colors.grey[400],
                                              );
                                            },
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        Text(
                                          "Aucun bien immobilier trouvé",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge
                                              ?.copyWith(
                                            fontWeight: FontWeight.w700,
                                            color: const Color(0xFF1E2022),
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                        Text(
                                          "Vérifiez vos filtres ou revenez plus tard",
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                            fontSize: 14,
                                            color: Colors.grey[500],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                                    : Column(
                                  children: value.filteredBienImmobiliers.map((bienImmobilier) {
                                    return Padding(
                                      padding: const EdgeInsets.only(bottom: 20),
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(24),
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
                            const SizedBox(height: 24),
                          ],
                        ),
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
                          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
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
                                  const SizedBox(height: 24),
                                  Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(12),
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
                                          fontWeight: FontWeight.w800,
                                          color: const Color(0xFF1E2022),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 26),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    borderRadius: BorderRadius.circular(16),
                                    child: Container(
                                      padding: const EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                        color: Colors.grey[50],
                                        borderRadius: BorderRadius.circular(16),
                                        border: Border.all(color: Colors.grey[100]!),
                                      ),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
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
                                                const SizedBox(height: 2),
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
                                    borderRadius: BorderRadius.circular(16),
                                    child: Container(
                                      padding: const EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                        color: Colors.grey[50],
                                        borderRadius: BorderRadius.circular(16),
                                        border: Border.all(color: Colors.grey[100]!),
                                      ),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
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
                                                const SizedBox(height: 2),
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
                                    borderRadius: BorderRadius.circular(16),
                                    child: Container(
                                      padding: const EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                        color: Colors.grey[50],
                                        borderRadius: BorderRadius.circular(16),
                                        border: Border.all(color: Colors.grey[100]!),
                                      ),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
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
                                  const SizedBox(height: 20),
                                  SizedBox(
                                    width: double.infinity,
                                    child: TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      style: TextButton.styleFrom(
                                        backgroundColor: Colors.grey[50],
                                        padding: const EdgeInsets.symmetric(vertical: 14),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(14),
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
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    decoration: BoxDecoration(
                      color: AppColors.green3,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.green3.withOpacity(0.45),
                          blurRadius: 24,
                          spreadRadius: 2,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.help_outline,
                          color: AppColors.black,
                          size: 21,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          "Besoin d'aide ?",
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.black,
                            fontWeight: FontWeight.w700,
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

