
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:take_a_walk_app/domain/models/responses/location.dart';
import 'package:take_a_walk_app/views/event/detail/bloc/detail_bloc.dart';
import 'package:take_a_walk_app/views/views_container.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {

  @override
  final List<AutoRoute> routes = [
    AutoRoute(page: SplashRoute.page),
    CustomRoute(page: LoginRoute.page, transitionsBuilder: TransitionsBuilders.fadeIn, durationInMilliseconds: 200),
    CustomRoute(page: RegisterRoute.page, transitionsBuilder: TransitionsBuilders.fadeIn, durationInMilliseconds: 200),
    CustomRoute(page: MyEventsRoute.page, transitionsBuilder: TransitionsBuilders.noTransition),
    CustomRoute(page: InvitesRoute.page, transitionsBuilder: TransitionsBuilders.noTransition),
    CustomRoute(page: MapRoute.page, transitionsBuilder: TransitionsBuilders.noTransition),
    CustomRoute(page: ProfileRoute.page, transitionsBuilder: TransitionsBuilders.noTransition),
    CustomRoute(page: CreateEventRoute.page, transitionsBuilder: TransitionsBuilders.slideLeftWithFade, durationInMilliseconds: 200),
    CustomRoute(page: EventDetailRoute.page, transitionsBuilder: TransitionsBuilders.fadeIn, durationInMilliseconds: 200),
    CustomRoute(page: EventEditRoute.page, transitionsBuilder: TransitionsBuilders.slideLeftWithFade, durationInMilliseconds: 200),
    CustomRoute(page: ProfileEditRoute.page, transitionsBuilder: TransitionsBuilders.noTransition),
    CustomRoute(page: ChatRoute.page, transitionsBuilder: TransitionsBuilders.noTransition),
    CustomRoute(page: PickPersonRoute.page, transitionsBuilder: TransitionsBuilders.noTransition),
    CustomRoute(page: PickLocationRoute.page, transitionsBuilder: TransitionsBuilders.noTransition),
    CustomRoute(page: FilterRoute.page, transitionsBuilder: TransitionsBuilders.noTransition),
    CustomRoute(page: ForecastRoute.page, transitionsBuilder: TransitionsBuilders.slideLeftWithFade, durationInMilliseconds: 200),
  ];
}