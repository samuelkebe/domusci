import 'package:pisso/resources/app_theme.dart';
import 'package:pisso/utils/langue_provider.dart';
import 'package:pisso/utils/theme_provider.dart';
import 'package:pisso/views-models/annonces_viewmodel.dart';
import 'package:pisso/views-models/auth_view_model.dart';
import 'package:pisso/views-models/explore_viewmodel.dart';
import 'package:pisso/views-models/favorites_view_model.dart';
import 'package:pisso/views-models/home_view_model.dart';
import 'package:pisso/views-models/listings_view_model.dart';
import 'package:pisso/views-models/messages_view_model.dart';
import 'package:pisso/views-models/notifications_view_model.dart';
import 'package:pisso/views-models/property_detail_view_model.dart';
import 'package:pisso/views-models/search_view_model.dart';
import 'package:pisso/views/splash/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(const Pisso());
}

class Pisso extends StatelessWidget {
  const Pisso({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => FavoritesViewModel()),
        ChangeNotifierProvider(create: (_) => HomeViewModel()),
        ChangeNotifierProvider(create: (_) => ListingsViewModel()),
        ChangeNotifierProvider(create: (_) => MessagesViewModel()),
        ChangeNotifierProvider(create: (_) => NotificationsViewModel()),
        ChangeNotifierProvider(create: (_) => PropertyDetailViewModel()),
        ChangeNotifierProvider(create: (_) => SearchViewModel()),
        ChangeNotifierProvider(create: (_) => ExplorerViewModel()),
        ChangeNotifierProvider(create: (_) => AnnoncesViewmodel()),
      ],
      child: MaterialApp(
        title: 'Domus CI',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.defaultTheme,
        darkTheme: AppTheme.defaultTheme,
        home: const SplashView(),
      ),
    );
  }
}

