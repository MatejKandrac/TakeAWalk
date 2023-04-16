

import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:take_a_walk_app/widget/app_button.dart';
import 'package:take_a_walk_app/widget/app_scaffold.dart';
import 'package:take_a_walk_app/widget/app_text_field.dart';

@RoutePage()
class PickLocationPage extends HookWidget {
  const PickLocationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final nameController = useTextEditingController();
    return AppScaffold(
      appBar: AppBar(
        title: Text("Choose location",
            style: Theme.of(context).textTheme.bodyMedium),
        automaticallyImplyLeading: true,
      ),
      navigationIndex: 2,
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              const Placeholder(),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    AppTextField(
                      controller: nameController,
                      labelText: 'Name',
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    AppButton.gradient(
                      onPressed: () {},
                      child: Text("Save changes",
                          style: Theme.of(context).textTheme.bodyMedium),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
