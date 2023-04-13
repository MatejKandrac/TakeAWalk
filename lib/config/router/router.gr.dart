// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'router.dart';

abstract class _$AppRouter extends RootStackRouter {
  _$AppRouter([GlobalKey<NavigatorState>? navigatorKey]) : super(navigatorKey);

  @override
  final Map<String, PageFactory> pagesMap = {
    MyEventsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const MyEventsPage(),
      );
    },
    ChatRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ChatPage(),
      );
    },
    RegisterRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const RegisterPage(),
      );
    },
    SplashRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SplashPage(),
      );
    },
    CreateEventRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const CreateEventPage(),
      );
    },
    PickPersonRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const PickPersonPage(),
      );
    },
    PickLocationRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const PickLocationPage(),
      );
    },
    ActiveDetailRoute.name: (routeData) {
      final args = routeData.argsAs<ActiveDetailRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ActiveDetailPage(
          key: args.key,
          event: args.event,
        ),
      );
    },
    InviteDetailRoute.name: (routeData) {
      final args = routeData.argsAs<InviteDetailRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: InviteDetailPage(
          key: args.key,
          event: args.event,
        ),
      );
    },
    ProfileEditRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ProfileEditPage(),
      );
    },
    ProfileRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ProfilePage(),
      );
    },
    InvitesRoute.name: (routeData) {
      final args = routeData.argsAs<InvitesRouteArgs>(
          orElse: () => const InvitesRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: InvitesPage(key: args.key),
      );
    },
    MapRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const MapPage(),
      );
    },
    LocationPickRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const PickLocationPage(),
      );
    },
    LoginRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const LoginPage(),
      );
    },
    FilterRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const FilterPage(),
      );
    },
  };
}

/// generated route for
/// [MyEventsPage]
class MyEventsRoute extends PageRouteInfo<void> {
  const MyEventsRoute({List<PageRouteInfo>? children})
      : super(
          MyEventsRoute.name,
          initialChildren: children,
        );

  static const String name = 'MyEventsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ChatPage]
class ChatRoute extends PageRouteInfo<void> {
  const ChatRoute({List<PageRouteInfo>? children})
      : super(
          ChatRoute.name,
          initialChildren: children,
        );

  static const String name = 'ChatRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [RegisterPage]
class RegisterRoute extends PageRouteInfo<void> {
  const RegisterRoute({List<PageRouteInfo>? children})
      : super(
          RegisterRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegisterRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SplashPage]
class SplashRoute extends PageRouteInfo<void> {
  const SplashRoute({List<PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CreateEventPage]
class CreateEventRoute extends PageRouteInfo<void> {
  const CreateEventRoute({List<PageRouteInfo>? children})
      : super(
          CreateEventRoute.name,
          initialChildren: children,
        );

  static const String name = 'CreateEventRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [PickPersonPage]
class PickPersonRoute extends PageRouteInfo<void> {
  const PickPersonRoute({List<PageRouteInfo>? children})
      : super(
          PickPersonRoute.name,
          initialChildren: children,
        );

  static const String name = 'PickPersonRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [PickLocationPage]
class PickLocationRoute extends PageRouteInfo<void> {
  const PickLocationRoute({List<PageRouteInfo>? children})
      : super(
          PickLocationRoute.name,
          initialChildren: children,
        );

  static const String name = 'PickLocationRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ActiveDetailPage]
class ActiveDetailRoute extends PageRouteInfo<ActiveDetailRouteArgs> {
  ActiveDetailRoute({
    Key? key,
    required EventResponse event,
    List<PageRouteInfo>? children,
  }) : super(
          ActiveDetailRoute.name,
          args: ActiveDetailRouteArgs(
            key: key,
            event: event,
          ),
          initialChildren: children,
        );

  static const String name = 'ActiveDetailRoute';

  static const PageInfo<ActiveDetailRouteArgs> page =
      PageInfo<ActiveDetailRouteArgs>(name);
}

class ActiveDetailRouteArgs {
  const ActiveDetailRouteArgs({
    this.key,
    required this.event,
  });

  final Key? key;

  final EventResponse event;

  @override
  String toString() {
    return 'ActiveDetailRouteArgs{key: $key, event: $event}';
  }
}

/// generated route for
/// [InviteDetailPage]
class InviteDetailRoute extends PageRouteInfo<InviteDetailRouteArgs> {
  InviteDetailRoute({
    Key? key,
    required EventResponse event,
    List<PageRouteInfo>? children,
  }) : super(
          InviteDetailRoute.name,
          args: InviteDetailRouteArgs(
            key: key,
            event: event,
          ),
          initialChildren: children,
        );

  static const String name = 'InviteDetailRoute';

  static const PageInfo<InviteDetailRouteArgs> page =
      PageInfo<InviteDetailRouteArgs>(name);
}

class InviteDetailRouteArgs {
  const InviteDetailRouteArgs({
    this.key,
    required this.event,
  });

  final Key? key;

  final EventResponse event;

  @override
  String toString() {
    return 'InviteDetailRouteArgs{key: $key, event: $event}';
  }
}

/// generated route for
/// [ProfileEditPage]
class ProfileEditRoute extends PageRouteInfo<void> {
  const ProfileEditRoute({List<PageRouteInfo>? children})
      : super(
          ProfileEditRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileEditRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ProfilePage]
class ProfileRoute extends PageRouteInfo<void> {
  const ProfileRoute({List<PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [InvitesPage]
class InvitesRoute extends PageRouteInfo<InvitesRouteArgs> {
  InvitesRoute({
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          InvitesRoute.name,
          args: InvitesRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'InvitesRoute';

  static const PageInfo<InvitesRouteArgs> page =
      PageInfo<InvitesRouteArgs>(name);
}

class InvitesRouteArgs {
  const InvitesRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'InvitesRouteArgs{key: $key}';
  }
}

/// generated route for
/// [MapPage]
class MapRoute extends PageRouteInfo<void> {
  const MapRoute({List<PageRouteInfo>? children})
      : super(
          MapRoute.name,
          initialChildren: children,
        );

  static const String name = 'MapRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [LocationPickPage]
class LocationPickRoute extends PageRouteInfo<void> {
  const LocationPickRoute({List<PageRouteInfo>? children})
      : super(
          LocationPickRoute.name,
          initialChildren: children,
        );

  static const String name = 'LocationPickRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [LoginPage]
class LoginRoute extends PageRouteInfo<void> {
  const LoginRoute({List<PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [FilterPage]
class FilterRoute extends PageRouteInfo<void> {
  const FilterRoute({List<PageRouteInfo>? children})
      : super(
          FilterRoute.name,
          initialChildren: children,
        );

  static const String name = 'FilterRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
