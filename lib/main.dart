import 'package:fb_ui_prj/const/theme_data_const.dart';
import 'package:fb_ui_prj/provider/fav_provider.dart';
import 'package:fb_ui_prj/provider/font_provider.dart';
import 'package:fb_ui_prj/provider/propic_provider.dart';
import 'package:fb_ui_prj/provider/theme_provider.dart';
import 'package:fb_ui_prj/view/business_article_view.dart';
import 'package:fb_ui_prj/view/ent_article_view.dart';
import 'package:fb_ui_prj/view/japan_article_view.dart';
import 'package:fb_ui_prj/view/profile_view.dart';
import 'package:fb_ui_prj/view/tech_article_view.dart';
import 'package:fb_ui_prj/view/world_article_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fb_ui_prj/view/main_app_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider/profile_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeProvider themeProvider = ThemeProvider();

  void getCurrentAppTheme() async {
    themeProvider.setDarkTheme =
        await themeProvider.darkThemePrefs.getDarkTheme();
  }

  @override
  initState() {
    getCurrentAppTheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => FavoriteProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => ThemeProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => FontProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => ProfileProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => RefreshProviderForJapanArticles(),
          ),
          ChangeNotifierProvider(
            create: (context) => RefreshProviderForWorldArticles(),
          ),
          ChangeNotifierProvider(
            create: (context) => RefreshProviderForBusinessArticles(),
          ),
          ChangeNotifierProvider(
            create: (context) => RefreshProviderForTechArticles(),
          ),
          ChangeNotifierProvider(
            create: (context) => RefreshProviderForEntArticles(),
          ),
          ChangeNotifierProvider(
            create: (context) => ProfilePictureProvider(),
          ),
        ],
        builder: (context, child) {
          final provider = Provider.of<ThemeProvider>(context);
          return MaterialApp(
            theme: Styles.themeData(provider.getDarkTheme, context),
            debugShowCheckedModeBanner: false,
            home: const MainAppScreen(),
          );
        });
  }
}
