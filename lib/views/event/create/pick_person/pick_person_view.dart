import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:take_a_walk_app/widget/app_scaffold.dart';

import '../../../../widget/app_button.dart';

@RoutePage()
class PickPersonPage extends HookWidget {
  const PickPersonPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final personController = useTextEditingController();
    return AppScaffold(
      appBar: AppBar(
        title: Text("Profile", style: Theme.of(context).textTheme.bodyMedium),
        automaticallyImplyLeading: true,
      ),
      navigationIndex: 0,
      child: SafeArea(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  color: Colors.white,
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10, left: 20),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            style: const TextStyle(color: Colors.black),
                            controller: personController,
                            decoration: const InputDecoration(
                              labelText: 'Enter username',
                              labelStyle: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.search,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(top: 20, bottom: 10),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: 20,
                      itemBuilder: (context, index) {
                        return Container(
                          height: 70,
                          child: Row(
                            children: const [
                              Icon(
                                Icons.account_circle,
                                size: 50,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Patreax',
                                style: TextStyle(fontSize: 25),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                AppButton.gradient(
                  onPressed: () {},
                  child: Text("Add person",
                      style: Theme.of(context).textTheme.bodyMedium),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
