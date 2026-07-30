import 'package:domusci/views/settings/settings_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/glass_bottom_bar.dart';
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

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => HomeViewModel()..getBienImmobiliers(),
        ),
      ],
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
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: IndexedStack(
            index: _index,
            children: const [
              HomeView(),
              // SearchView(),
              SettingView(),
            ],
          ),
          bottomNavigationBar: GlassBottomNavBar(
            currentIndex: _index,
            onTap: (index) => setState(() => _index = index),
            onPublishTap: _openPublish,
          ),
        ),
      ),
    );
  }
}