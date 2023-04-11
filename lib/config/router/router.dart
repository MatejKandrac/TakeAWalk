
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:take_a_walk_app/views/views_container.dart';

import '../../views/map/location_pick_view.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {

  @override
  final List<AutoRoute> routes = [
    AutoRoute(page: SplashRoute.page),
    CustomRoute(page: LoginRoute.page, transitionsBuilder: TransitionsBuilders.fadeIn, durationInMilliseconds: 400),
    CustomRoute(page: RegisterRoute.page, transitionsBuilder: TransitionsBuilders.fadeIn, durationInMilliseconds: 400),
    CustomRoute(page: MyEventsRoute.page, transitionsBuilder: TransitionsBuilders.noTransition),
    CustomRoute(page: InvitesRoute.page, transitionsBuilder: TransitionsBuilders.noTransition),
    CustomRoute(page: MapRoute.page, transitionsBuilder: TransitionsBuilders.noTransition),
    CustomRoute(page: ProfileRoute.page, transitionsBuilder: TransitionsBuilders.noTransition),
    CustomRoute(page: ProfileEditRoute.page, transitionsBuilder: TransitionsBuilders.noTransition),
    CustomRoute(page: ChatRoute.page, transitionsBuilder: TransitionsBuilders.noTransition),
    CustomRoute(page: PickPersonRoute.page, transitionsBuilder: TransitionsBuilders.noTransition),
    CustomRoute(page: LocationPickRoute.page, transitionsBuilder: TransitionsBuilders.noTransition),
    CustomRoute(page: FilterRoute.page, transitionsBuilder: TransitionsBuilders.noTransition),
  ];


}