import 'package:domusci/models/bien_immobilier_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_skeleton_ui/flutter_skeleton_ui.dart';

import '../../components/card_bien_immobilier.dart';
import '../../models/enum/statut_bien_immobilier.dart';
import '../../models/enum/type_bien_immobilier.dart';
import '../../resources/color.dart';
import '../../views-models/home_view_model.dart';

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
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<HomeViewModel>(
        builder: (context, value, child) {
          return Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFEAF5DE), // Fond dégradé verdâtre doux en haut
                  Color(0xFFF7FAF2),
                ],
              ),
            ),
            child: SafeArea(
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),

                    // En-tête : Menu, Notification, Profil
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
                                size: 48 * 0.45
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
                                  size: 48 * 0.45
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
                        const CircleAvatar(
                          radius: 24,
                          backgroundImage: NetworkImage(
                            'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=200&q=80',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Titre principal et bouton de recherche
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Made for You',
                                style: TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF1E2229),
                                  height: 1.2,
                                ),
                              ),
                              Text(
                                'Explore Properties',
                                style: TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF1E2229),
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

                    // Filtres sous forme de pilules (All, House, Apartment, etc.)
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      clipBehavior: Clip.none,
                      child: Row(
                        children: [
                          // Bouton "All" sélectionné (Vert citron)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 14,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE1F57A),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: const Text(
                              'All',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF1E2022),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Container(
                            padding: const EdgeInsets.only(left: 6, right: 18, top: 6, bottom: 6),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: Colors.white.withOpacity(0.8)),
                            ),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.network(
                                    "https://images.unsplash.com/photo-1570129477492-45c003edd2be?auto=format&fit=crop&w=100&q=80",
                                    width: 32,
                                    height: 32,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  "Maison",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF1E2022),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          Container(
                            padding: const EdgeInsets.only(left: 6, right: 18, top: 6, bottom: 6),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: Colors.white.withOpacity(0.8)),
                            ),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.network(
                                    "https://images.unsplash.com/photo-1545324418-cc1a3fa10c00?auto=format&fit=crop&w=100&q=80",
                                    width: 32,
                                    height: 32,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  "Appartements",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF1E2022),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 28),

                    // Section "Recommandez pour vous"
                    const Text(
                      'Recommandez pour vous',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E2022),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Cartes de propriétés avec Skeleton
                    Skeleton(
                      isLoading: value.isLoadingBienImmobiliers,
                      skeleton: SkeletonListView(),
                      child: RefreshIndicator(
                        color: AppColors.primaryColor,
                        onRefresh: () async {
                           value.getBienImmobiliers();
                        },
                        child: value.bienImmobiliers.isEmpty
                        // ---------- EMPTY STATE ----------
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
                                  style: Theme.of(context).textTheme.bodyLarge
                                      ?.copyWith(fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  "Vérifiez vos filtres ou revenez plus tard",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[400],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                        // ---------- LIST ----------
                            : Column(
                          children: value.bienImmobiliers.map((bienImmobilier) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: InkWell(
                                onTap: () {},
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
          );
        },
      ),    );
  }
}
