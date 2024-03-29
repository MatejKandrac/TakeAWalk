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
      final args = routeData.argsAs<MyEventsRouteArgs>(
          orElse: () => const MyEventsRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: MyEventsPage(key: args.key),
      );
    },
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
    ForecastRoute.name: (routeData) {
      final args = routeData.argsAs<ForecastRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ForecastPage(
          args.dateRange,
          args.location,
          key: args.key,
        ),
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
    EventEditRoute.name: (routeData) {
      final args = routeData.argsAs<EventEditRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: EventEditPage(
          editArguments: args.editArguments,
          key: args.key,
        ),
      );
    },
    EventDetailRoute.name: (routeData) {
      final args = routeData.argsAs<EventDetailRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: EventDetailPage(
          key: args.key,
          eventId: args.eventId,
        ),
      );
    },
    InvitesRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const InvitesPage(),
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
    CreateEventRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const CreateEventPage(),
      );
    },
  };
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
/// [ForecastPage]
class ForecastRoute extends PageRouteInfo<ForecastRouteArgs> {
  ForecastRoute({
    required String dateRange,
    required Location location,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          ForecastRoute.name,
          args: ForecastRouteArgs(
            dateRange: dateRange,
            location: location,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'ForecastRoute';

  static const PageInfo<ForecastRouteArgs> page =
      PageInfo<ForecastRouteArgs>(name);
}

class ForecastRouteArgs {
  const ForecastRouteArgs({
    required this.dateRange,
    required this.location,
    this.key,
  });

  final String dateRange;

  final Location location;

  final Key? key;

  @override
  String toString() {
    return 'ForecastRouteArgs{dateRange: $dateRange, location: $location, key: $key}';
  }
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
/// [EventEditPage]
class EventEditRoute extends PageRouteInfo<EventEditRouteArgs> {
  EventEditRoute({
    required EditArguments editArguments,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          EventEditRoute.name,
          args: EventEditRouteArgs(
            editArguments: editArguments,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'EventEditRoute';

  static const PageInfo<EventEditRouteArgs> page =
      PageInfo<EventEditRouteArgs>(name);
}

class EventEditRouteArgs {
  const EventEditRouteArgs({
    required this.editArguments,
    this.key,
  });

  final EditArguments editArguments;

  final Key? key;

  @override
  String toString() {
    return 'EventEditRouteArgs{editArguments: $editArguments, key: $key}';
  }
}

/// generated route for
/// [EventDetailPage]
class EventDetailRoute extends PageRouteInfo<EventDetailRouteArgs> {
  EventDetailRoute({
    Key? key,
    required int eventId,
    List<PageRouteInfo>? children,
  }) : super(
          EventDetailRoute.name,
          args: EventDetailRouteArgs(
            key: key,
            eventId: eventId,
          ),
          initialChildren: children,
        );

  static const String name = 'EventDetailRoute';

  static const PageInfo<EventDetailRouteArgs> page =
      PageInfo<EventDetailRouteArgs>(name);
}

class EventDetailRouteArgs {
  const EventDetailRouteArgs({
    this.key,
    required this.eventId,
  });

  final Key? key;

  final int eventId;

  @override
  String toString() {
    return 'EventDetailRouteArgs{key: $key, eventId: $eventId}';
  }
}

/// generated route for
/// [InvitesPage]
class InvitesRoute extends PageRouteInfo<void> {
  const InvitesRoute({List<PageRouteInfo>? children})
      : super(
          InvitesRoute.name,
          initialChildren: children,
        );

  static const String name = 'InvitesRoute';

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
