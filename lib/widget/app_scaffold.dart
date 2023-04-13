
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:take_a_walk_app/config/router/router.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    Key? key,
    required this.appBar,
    required this.navigationIndex,
    required this.child,
    this.fab}) : super(key: key);

  final Widget child;
  final int navigationIndex;
  final AppBar appBar;
  final Widget? fab;


  void _onNavigationSelected(int value, BuildContext context) {
    PageRouteInfo nextRoute;
    switch (value) {
      case 0:
        nextRoute = const MyEventsRoute();
        break;
      case 1:
        nextRoute = InvitesRoute();
        break;
      case 2:
        nextRoute = const MapRoute();
        break;
      case 3:
        nextRoute = const ProfileRoute();
        break;
      default:
        throw Exception("Invalid route index $value");
    }
    AutoRouter.of(context).pushAndPopUntil(
        nextRoute,
        predicate: (route) => nextRoute is MyEventsRoute ? false : (route.settings.name == MyEventsRoute.name)
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 60),
        child: appBar,
      ),
      floatingActionButton: fab,
      body: child,
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Color(0xff000000),
                blurRadius: 10,
                offset: Offset(0, 5)
            )
          ]
        ),
        child: NavigationBar(
          onDestinationSelected: (value) => _onNavigationSelected(value, context),
          selectedIndex: navigationIndex,
          destinations: const [
            NavigationDestination(
                icon: Icon(Icons.calendar_month),
                label: "My events"
            ),
            NavigationDestination(
                icon: Icon(Icons.list),
                label: "Invites"
            ),
            NavigationDestination(
                icon: Icon(Icons.map_outlined),
                label: "Map"
            ),
            NavigationDestination(
                icon: Icon(Icons.account_circle),
                label: "Profile"
            ),
          ],
        ),
      ),
    );
  }

}
