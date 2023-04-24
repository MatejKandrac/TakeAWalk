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
    ChatRoute.name: (routeData) {
      final args = routeData.argsAs<ChatRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ChatPage(
          key: args.key,
          eventId: args.eventId,
        ),
      );
    },
    CreateEventRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const CreateEventPage(),
      );
    },
    PickLocationRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const PickLocationPage(),
      );
    },
    PickPersonRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const PickPersonPage(),
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
    FilterRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const FilterPage(),
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
    LoginRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const LoginPage(),
      );
    },
    MapRoute.name: (routeData) {
      final args =
          routeData.argsAs<MapRouteArgs>(orElse: () => const MapRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: MapPage(key: args.key),
      );
    },
    MyEventsRoute.name: (routeData) {
      final args = routeData.argsAs<MyEventsRouteArgs>(
          orElse: () => const MyEventsRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: MyEventsPage(key: args.key),
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
  };
}

/// generated route for
/// [ChatPage]
class ChatRoute extends PageRouteInfo<ChatRouteArgs> {
  ChatRoute({
    Key? key,
    required int eventId,
    List<PageRouteInfo>? children,
  }) : super(
          ChatRoute.name,
          args: ChatRouteArgs(
            key: key,
            eventId: eventId,
          ),
          initialChildren: children,
        );

  static const String name = 'ChatRoute';

  static const PageInfo<ChatRouteArgs> page = PageInfo<ChatRouteArgs>(name);
}

class ChatRouteArgs {
  const ChatRouteArgs({
    this.key,
    required this.eventId,
  });

  final Key? key;

  final int eventId;

  @override
  String toString() {
    return 'ChatRouteArgs{key: $key, eventId: $eventId}';
  }
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
/// [MapPage]
class MapRoute extends PageRouteInfo<MapRouteArgs> {
  MapRoute({
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          MapRoute.name,
          args: MapRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'MapRoute';

  static const PageInfo<MapRouteArgs> page = PageInfo<MapRouteArgs>(name);
}

class MapRouteArgs {
  const MapRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'MapRouteArgs{key: $key}';
  }
}

/// generated route for
/// [MyEventsPage]
class MyEventsRoute extends PageRouteInfo<MyEventsRouteArgs> {
  MyEventsRoute({
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          MyEventsRoute.name,
          args: MyEventsRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'MyEventsRoute';

  static const PageInfo<MyEventsRouteArgs> page =
      PageInfo<MyEventsRouteArgs>(name);
}

class MyEventsRouteArgs {
  const MyEventsRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'MyEventsRouteArgs{key: $key}';
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
