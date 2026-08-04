import 'package:flutter/material.dart';
import 'package:flutter_skeleton_ui/flutter_skeleton_ui.dart';
import 'package:pisso/views/annonces/detail_annonce_view.dart';
import 'package:provider/provider.dart';

import '../../components/card_annonce.dart';
import '../../resources/color.dart';
import '../../views-models/annonces_viewmodel.dart';

class AnnonceView extends StatefulWidget {
  const AnnonceView({super.key});

  @override
  State<AnnonceView> createState() => _AnnonceViewState();
}


class _AnnonceViewState extends State<AnnonceView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final viewModel = Provider.of<AnnoncesViewmodel>(context, listen: false,);
      viewModel.getAnnonces();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      body: Consumer<AnnoncesViewmodel>(
        builder: (context, annoncesVm, child) {

          return Container(
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
                onRefresh: () async {
                  annoncesVm.getAnnonces();
                },
                color: AppColors.primaryColor,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
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
                                Icons.arrow_back_ios,
                                color: const Color(0xFF1E2022),
                                size: 48 * 0.45,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Text(
                            "Mes annonces",
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                        child: Skeleton(
                          isLoading: annoncesVm.isLoadingAnnonces,
                          skeleton: SkeletonListView(),
                          child: annoncesVm.annonces.isEmpty
                              ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.description_outlined,
                                  size: 80,
                                  color: AppColors.black,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'Aucune annonce trouvée',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(color: AppColors.black),
                                ),
                              ],
                            ),
                          )
                              : ListView.builder(
                            itemCount: annoncesVm.annonces.length,
                            padding: const EdgeInsets.only(bottom: 16),
                            itemBuilder: (context, index) {
                              final annonce = annoncesVm.annonces[index];
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: InkWell(
                                  onTap: () {
                                    annoncesVm.setSelectedAnnonce(annonce);
                                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                                      return DetailAnnonceView(annonce: annonce);
                                    },));
                                  },
                                  child: CardAnnonce(
                                    annonce: annonce,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
