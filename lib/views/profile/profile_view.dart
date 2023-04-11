import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:take_a_walk_app/config/router/router.dart';
import 'package:take_a_walk_app/views/filter/filter_view.dart';
import 'package:take_a_walk_app/widget/app_scaffold.dart';

import '../../widget/app_swith.dart';

@RoutePage()
class ProfilePage extends HookWidget {
  const ProfilePage({Key? key}) : super(key: key);

  _onEdit(BuildContext context) {
    AutoRouter.of(context).push(const ProfileEditRoute());
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        title: Text("Profile", style: Theme.of(context).textTheme.bodyMedium),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () => _onEdit(context), icon: const Icon(Icons.edit))
        ],
      ),
      navigationIndex: 3,
      child: SafeArea(
        child: Scaffold(
          body: Padding(
            padding:
                const EdgeInsets.only(top: 10, bottom: 10, right: 10, left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      Positioned.fill(
                        top: 35,
                        child: Card(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 110, left: 10, right: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text(
                                  'User name',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  // 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                                  'This is my profile description with my info, my interests but most importantly, I am just interested in how it is going to fit inside this card',
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Divider(
                                  color: Colors.white,
                                  thickness: 1,
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 5),
                                  child: Row(
                                    children: const [
                                      Icon(
                                        Icons.mail_outline,
                                        size: 35,
                                      ),
                                      SizedBox(width: 10),
                                      Text('kenji_matej@gmail.com')
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const Align(
                        alignment: Alignment.topCenter,
                        child: Icon(Icons.account_circle, size: 150),
                      )
                    ],
                  ),
                ),
                // Expanded(child: SizedBox()),
                Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.notifications_active_outlined,
                          size: 35,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Notifications',
                          style: TextStyle(fontSize: 25),
                        ),
                        Spacer(),
                        AppSwitch(),
                      ],
                    ),
                  ),
                ),
                Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        debugPrint('Logged out');
                      },
                      child: Row(
                        children: const [
                          Icon(
                            Icons.logout,
                            size: 35,
                            color: Color(0xffF20AB8),
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Log out',
                            style: TextStyle(
                              fontSize: 25,
                              color: Color(0xffF20AB8),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

