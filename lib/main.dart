import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:take_a_walk_app/config/router/router.dart';
import 'package:take_a_walk_app/di.dart';
import 'package:take_a_walk_app/views/bloc_container.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'config/firebase_options.dart';
import 'config/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  initializeDateFormatting();
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
    return MultiBlocProvider(
      providers: [
        BlocProvider<SplashBloc>(create: (context) => di()),
        BlocProvider<LoginBloc>(create: (context) => di(), lazy: true),
        BlocProvider<RegisterBloc>(create: (context) => di(), lazy: true),
        BlocProvider<ProfileBloc>(create: (context) => di(), lazy: true),
        BlocProvider<MyEventsBloc>(create: (context) => di(), lazy: true),
        BlocProvider<InvitesBloc>(create: (context) => di(), lazy: true),
        BlocProvider<ChatBloc>(create: (context) => di(), lazy: true),
      ],
      child: MaterialApp.router(
        routerConfig: _appRouter.config(
          initialRoutes: [
            const SplashRoute()
          ]
        ),
        title: 'TakeAWalk',
        debugShowCheckedModeBanner: false,
        theme: themeData
      ),
    );
  }
}
