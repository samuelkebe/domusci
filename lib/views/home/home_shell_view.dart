import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../views-models/favorites_view_model.dart';
import '../../views-models/home_view_model.dart';
import '../../views-models/search_view_model.dart';
import '../favorites/favorites_view.dart';
import '../profile/profile_view.dart';
import '../publish/publish_view.dart';
import '../search/search_view.dart';
import 'home_view.dart';

class HomeShellView extends StatefulWidget {
  const HomeShellView({super.key});

  @override
  State<HomeShellView> createState() => _HomeShellViewState();
}

class _HomeShellViewState extends State<HomeShellView> {
  int _index = 0;

  void _openPublish() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const PublishView()),
    );
  }

  Widget _buildNavItem({
    required int index,
    required IconData icon,
    required IconData activeIcon,
  }) {
    final isSelected = _index == index;

    return GestureDetector(
      onTap: () => setState(() => _index = index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF0C45B7) : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Icon(
          isSelected ? activeIcon : icon,
          color: isSelected ? const Color(0xFF1E2022) : const Color(0xFF757575),
          size: isSelected ? 20 : 22,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeViewModel()..getBienImmobiliers()),
        // ChangeNotifierProvider(create: (_) => SearchViewModel()..search()),
        // ChangeNotifierProvider(create: (_) => FavoritesViewModel()..load()),
      ],
      child: Scaffold(
        body: IndexedStack(
          index: _index,
          children: const [
            HomeView(),
            SearchView(),
            // FavoritesView(),
            ProfilView(),
          ],
        ),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Container(
              height: 64,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.85),
                borderRadius: BorderRadius.circular(40),
                border: Border.all(color: Colors.white),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildNavItem(
                    index: 0,
                    icon: Icons.home_outlined,
                    activeIcon: Icons.home,
                  ),
                  _buildNavItem(
                    index: 1,
                    icon: Icons.search,
                    activeIcon: Icons.search,
                  ),
                  // Bouton central de publication
                  GestureDetector(
                    onTap: _openPublish,
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.attach_money,
                        color: Color(0xFF757575),
                        size: 22,
                      ),
                    ),
                  ),
                  _buildNavItem(
                    index: 2,
                    icon: Icons.settings_outlined,
                    activeIcon: Icons.settings,
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}