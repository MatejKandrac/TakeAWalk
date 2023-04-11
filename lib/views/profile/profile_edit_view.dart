import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:take_a_walk_app/config/theme.dart';
import 'package:take_a_walk_app/widget/app_scaffold.dart';
import 'package:take_a_walk_app/widget/app_text_field.dart';

import '../../widget/app_button.dart';

@RoutePage()
class ProfileEditPage extends HookWidget {
  const ProfileEditPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final usernameController = useTextEditingController();
    final passwordController = useTextEditingController();
    final confirmPassController = useTextEditingController();

    return AppScaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title:
            Text("Edit Profile", style: Theme.of(context).textTheme.bodyMedium),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.save))],
      ),
      navigationIndex: 3,
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  const Icon(Icons.account_circle, size: 150),
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                        side: BorderSide(
                            // color: Color(0xffF20AB8), width: 1),
                            color: themeData.colorScheme.primary,
                            width: 1),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        padding: const EdgeInsets.only(
                            top: 10, bottom: 10, left: 50, right: 50)),
                    child: const Text(
                      'Edit',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const Divider(thickness: 2),
                  Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Username:'),
                                AppTextField(
                                  controller: usernameController,
                                  labelText: "New username",
                                  inputAction: TextInputAction.next,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Password:'),
                                AppTextField(
                                  controller: passwordController,
                                  labelText: "New password",
                                  inputAction: TextInputAction.next,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Confirm password:'),
                                AppTextField(
                                  controller: confirmPassController,
                                  labelText: "Confirm password",
                                  inputAction: TextInputAction.next,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text('Description:', textAlign: TextAlign.left),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(10),
                      child: TextField(
                        maxLines: 8,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: AppButton.gradient(
                      onPressed: () {},
                      child: Text("Save changes",
                          style: Theme.of(context).textTheme.bodyMedium),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
