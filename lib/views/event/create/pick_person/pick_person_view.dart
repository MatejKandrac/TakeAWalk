import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:take_a_walk_app/di.dart';
import 'package:take_a_walk_app/domain/models/responses/profile_response.dart';
import 'package:take_a_walk_app/views/event/create/pick_person/bloc/pick_person_bloc.dart';
import 'package:take_a_walk_app/widget/app_button.dart';
import 'package:take_a_walk_app/widget/app_scaffold.dart';
import 'package:take_a_walk_app/widget/success_dialog.dart';


@RoutePage()
class PickPersonPage extends HookWidget {
  const PickPersonPage({Key? key}) : super(key: key);

  _onTextChanged(String text, BuildContext context) {
    BlocProvider.of<PickPersonBloc>(context).postFetch(text);
  }

  @override
  Widget build(BuildContext context) {
    final personController = useTextEditingController();
    final bloc = useMemoized<PickPersonBloc>(() => di());
    return BlocProvider<PickPersonBloc>(
      create: (context) => bloc,
      child: BlocListener<PickPersonBloc, PickPersonState>(
        listener: (context, state) {
          if (state is PickPersonErrorState) {
            showStateDialog(context: context, isSuccess: false, closeOnConfirm: true, text: state.text);
          }
        },
        child: BlocBuilder<PickPersonBloc, PickPersonState>(
          buildWhen: (previous, current) => current is! PickPersonErrorState,
          builder: (context, state) => AppScaffold(
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
                      Container(
                        padding: const EdgeInsets.only(right: 10, left: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withAlpha(100)
                            )
                          ]
                        ),
                        child: TextField(
                          style: const TextStyle(color: Colors.black),
                          controller: personController,
                          onChanged: (value) => _onTextChanged(value, context),
                          decoration: InputDecoration(
                            hintText: 'Enter username',
                            hintStyle: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey),
                            labelStyle: const TextStyle(color: Colors.black),
                            suffixIcon: const Icon(Icons.search, color: Colors.black),
                            border: InputBorder.none
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(top: 20, bottom: 10),
                          child: (state is PickPersonLoadingState) ?
                          const Center(child: CircularProgressIndicator())
                          : ListView.builder(
                            shrinkWrap: true,
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemCount: 20,
                            itemBuilder: (context, index) {
                              return SizedBox(
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
          ),
        ),
      ),
    );
  }
}
