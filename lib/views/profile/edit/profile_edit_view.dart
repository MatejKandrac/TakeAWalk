import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:take_a_walk_app/config/theme.dart';
import 'package:take_a_walk_app/di.dart';
import 'package:take_a_walk_app/views/profile/edit/bloc/profile_edit_bloc.dart';
import 'package:take_a_walk_app/widget/app_text_field.dart';
import 'package:take_a_walk_app/widget/image_pick_choice.dart';
import 'package:take_a_walk_app/widget/loading_dialog.dart';
import 'package:take_a_walk_app/widget/state_dialog.dart';

import '../../../widget/app_button.dart';

@RoutePage()
class ProfileEditPage extends HookWidget {
  const ProfileEditPage({Key? key}) : super(key: key);

  _onEdit(BuildContext context, String newUsername, String newPassword, String confirmPassword, String newBio) {
    BlocProvider.of<ProfileEditBloc>(context).editProfileData(newUsername, newPassword, confirmPassword, newBio);
  }

  _onImagePick(BuildContext context) {
    showModalBottomSheet<bool>(
        context: context,
        builder: (context) => const ImagePickChoice(),
    ).then((value) {
      if (value != null) {
        BlocProvider.of<ProfileEditBloc>(context).updateImage(value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final usernameController = useTextEditingController();
    final passwordController = useTextEditingController();
    final confirmPassController = useTextEditingController();
    final bioController = useTextEditingController();

    final bloc = useMemoized<ProfileEditBloc>(() => di(), const []);

    useEffect(() {
      bloc.loadingStream.listen((event) {
        if (event) {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => const LoadingDialog(loadingText: "Updating profile...",));
        } else {
          Navigator.of(context).pop();
        }
      });
      return null;
    });

    return BlocProvider<ProfileEditBloc>(
      create: (context) => bloc,
      child: BlocListener<ProfileEditBloc, ProfileEditState>(
        listener: (context, state) {
          if (state.failed) {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              showStateDialog(context: context, isSuccess: false, text: "Failed to upload data", closeOnConfirm: true);
            });
          }
          if (state.success) {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              showStateDialog(context: context, isSuccess: true, text: "Data updated")
                  .then((value) => Navigator.of(context).pop());
            });
          }
          if (state.pictureError) {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              showStateDialog(context: context, isSuccess: false, text: "Failed to update image", closeOnConfirm: true);
            });
          }
          if (state.passwordError) {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              showStateDialog(context: context, isSuccess: false, text: "Passwords do not match", closeOnConfirm: true);
            });
          }
        },
        child: BlocBuilder<ProfileEditBloc, ProfileEditState>(
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
                          if (state.selectedImage == null) const Icon(Icons.account_circle, size: 150)
                          else ClipRRect(
                            borderRadius: BorderRadius.circular(75),
                            child: SizedBox(
                              width: 150,
                              height: 150,
                              child: Image.file(state.selectedImage!, fit: BoxFit.cover),
                            ),
                          ),
                          OutlinedButton(
                            onPressed: () => _onImagePick(context),
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
                                          inputAction: TextInputAction.next
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
                                          inputAction: TextInputAction.next
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
                                          inputAction: TextInputAction.next
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
      ),
    );
  }
}
