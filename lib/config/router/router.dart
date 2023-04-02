
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../ui/view/views_container.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {

  @override
  final List<AutoRoute> routes = [
    AutoRoute(page: SplashRoute.page),
    CustomRoute(page: LoginRoute.page, transitionsBuilder: TransitionsBuilders.fadeIn, durationInMilliseconds: 400),
    CustomRoute(page: RegisterRoute.page, transitionsBuilder: TransitionsBuilders.fadeIn, durationInMilliseconds: 400)
  ];


}