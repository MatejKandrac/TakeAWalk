import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:take_a_walk_app/features/splash/ui/splash_view.dart';

import 'config/firebase_options.dart';
import 'config/routes.dart';
import 'config/theme.dart';

void main() async {
  if (Platform.isAndroid) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } else {
    print("WARNING, YOU ARE RUNNING THIS APP ON UNSUPPORTED PLATFORM, FIREBASE NOT INITIALIZED");
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TakeAWalk',
      debugShowCheckedModeBanner: false,
      theme: themeData,
      initialRoute: AppRoutes.splashRoute,
      routes: {
        AppRoutes.splashRoute: (context) => const SplashView()
      }
    );
  }
}
