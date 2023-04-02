import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:take_a_walk_app/config/router/router.dart';
import 'package:take_a_walk_app/di.dart';

import 'config/firebase_options.dart';
import 'config/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  if (Platform.isAndroid) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } else {
    debugPrint("WARNING, YOU ARE RUNNING THIS APP ON UNSUPPORTED PLATFORM, FIREBASE NOT INITIALIZED");
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  final _appRouter = AppRouter();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _appRouter.config(
        initialRoutes: [
          const SplashRoute()
        ]
      ),
      title: 'TakeAWalk',
      debugShowCheckedModeBanner: false,
      theme: themeData
    );
  }
}
