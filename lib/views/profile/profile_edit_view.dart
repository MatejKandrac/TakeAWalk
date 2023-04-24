import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:take_a_walk_app/config/router/router.dart';
import 'package:take_a_walk_app/config/theme.dart';
import 'package:take_a_walk_app/views/bloc_container.dart';
import 'package:take_a_walk_app/widget/app_text_field.dart';

import '../../widget/app_button.dart';
import '../../widget/state_dialog.dart';

@RoutePage()
class ProfileEditPage extends HookWidget {
  const ProfileEditPage({Key? key}) : super(key: key);

  _onEdit(BuildContext context, String newUsername, String newPassword, String confirmPassword, String newBio) {
    BlocProvider.of<ProfileBloc>(context).editProfileData(newUsername, newPassword, confirmPassword, newBio);
    showStateDialog(context: context, isSuccess: true, text: "Changes saved!")
        // .then((value) => AutoRouter.of(context).replace(const ProfileRoute()));
        .then((value) => AutoRouter.of(context).pop());
  }

  @override
  Widget build(BuildContext context) {
    final usernameController = useTextEditingController();
    final passwordController = useTextEditingController();
    final confirmPassController = useTextEditingController();
    final bioController = useTextEditingController();

    final bloc = useMemoized<ProfileBloc>(() => BlocProvider.of(context));
    useEffect(() {
      bloc.emitProfileFormState();
      return null;
    }, const []);
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {},
      child: BlocBuilder<ProfileBloc, ProfileState>(
        buildWhen: (previous, current) => current is ProfileFormState,
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: true,
              title: Text("Edit Profile", style: Theme.of(context).textTheme.bodyMedium),
              actions: [
                IconButton(
                    onPressed: () => _onEdit(context, usernameController.text, passwordController.text,
                        confirmPassController.text, bioController.text),
                    icon: const Icon(Icons.save)),
              ],
            ),
            body: SafeArea(
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
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                              padding: const EdgeInsets.only(top: 10, bottom: 10, left: 50, right: 50)),
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
                                        errorText:
                                            (state as ProfileFormState).usernameError ? "This field is required" : null,
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
                                        obscureText: true,
                                        inputAction: TextInputAction.next,
                                        errorText: state.passwordError ? "Password does not match" : null,
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
                                        obscureText: true,
                                        inputAction: TextInputAction.next,
                                        errorText: state.passwordError ? "Password does not match" : null,
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
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: TextField(
                              // child: AppTextField(
                              controller: bioController,
                              maxLines: 8,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 20),
                          child: AppButton.gradient(
                            onPressed: () => _onEdit(context, usernameController.text, passwordController.text,
                                confirmPassController.text, bioController.text),
                            child: Text("Save changes", style: Theme.of(context).textTheme.bodyMedium),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
