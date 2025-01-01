import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tourist_project_mc/core/app_route.dart';
import 'package:tourist_project_mc/core/style/app_theme.dart';
import 'package:tourist_project_mc/features/locations/data/database/hive_manager.dart';

import 'core/theme_notifier.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await HiveDatabaseManager.initHive();
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeNotifierProvider);

    return MaterialApp(
      title: 'Flutter Demo',
      theme: themeMode == ThemeMode.light ? lightTheme : darkTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoute.splash,
      onGenerateRoute: AppRoute.generateRoute,
    );
  }
}
