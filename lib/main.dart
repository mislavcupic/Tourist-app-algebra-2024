import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tourist_project_mc/core/app_route.dart';
import 'package:tourist_project_mc/core/style/app_theme.dart';
import 'package:tourist_project_mc/features/locations/data/database/hive_manager.dart';

import 'core/NavigationObserver.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await HiveDatabaseManager.initHive();
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorObservers: [NavigationObserver()],
      title: 'Flutter Demo',
      theme: lightTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoute.splash,
      onGenerateRoute: AppRoute.generateRoute,
    );
  }
}
