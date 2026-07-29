import 'package:domusci/resources/app_theme.dart';
import 'package:domusci/utils/langue_provider.dart';
import 'package:domusci/utils/theme_provider.dart';
import 'package:domusci/views-models/auth_view_model.dart';
import 'package:domusci/views-models/explore_viewmodel.dart';
import 'package:domusci/views-models/favorites_view_model.dart';
import 'package:domusci/views-models/home_view_model.dart';
import 'package:domusci/views-models/listings_view_model.dart';
import 'package:domusci/views-models/messages_view_model.dart';
import 'package:domusci/views-models/notifications_view_model.dart';
import 'package:domusci/views-models/property_detail_view_model.dart';
import 'package:domusci/views-models/publish_view_model.dart';
import 'package:domusci/views-models/search_view_model.dart';
import 'package:domusci/views/splash/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(const DomusCI());
}

class DomusCI extends StatelessWidget {
  const DomusCI({super.key});

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
        ChangeNotifierProvider(create: (_) => PublishViewModel()),
        ChangeNotifierProvider(create: (_) => SearchViewModel()),
        ChangeNotifierProvider(create: (_) => ExplorerViewModel()),
      ],
      child: MaterialApp(
        title: 'Domus CI',
        debugShowCheckedModeBanner: false,
        home: const SplashView(),
      ),
    );
  }
}
