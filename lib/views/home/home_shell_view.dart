import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../views-models/favorites_view_model.dart';
import '../../views-models/home_view_model.dart';
import '../../views-models/search_view_model.dart';
import '../favorites/favorites_view.dart';
import '../profile/profile_view.dart';
import '../publish/publish_view.dart';
import '../search/search_view.dart';
import '../widgets/navigation/domus_bottom_nav.dart';
import 'home_view.dart';

/// Coquille principale — porte la Bottom Navigation à 5 onglets et bascule
/// entre Accueil / Explorer / Favoris / Profil ; Publier ouvre un flux dédié.
class HomeShellView extends StatefulWidget {
  const HomeShellView({super.key});

  @override
  State<HomeShellView> createState() => _HomeShellViewState();
}

class _HomeShellViewState extends State<HomeShellView> {
  int _index = 0;

  void _openPublish() {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => const PublishView()));
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeViewModel()..loadHome()),
        ChangeNotifierProvider(create: (_) => SearchViewModel()..search()),
        ChangeNotifierProvider(create: (_) => FavoritesViewModel()..load()),
      ],
      child: Scaffold(
        body: IndexedStack(
          index: _index,
          children: const [
            HomeView(),
            SearchView(),
            FavoritesView(),
            ProfileView(),
          ],
        ),
        bottomNavigationBar: DomusBottomNav(
          currentIndex: _index,
          onTap: (i) => setState(() => _index = i),
          onPublishTap: _openPublish,
        ),
      ),
    );
  }
}
