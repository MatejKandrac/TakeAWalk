import 'package:app_settings/app_settings.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:take_a_walk_app/config/router/router.dart';
import 'package:take_a_walk_app/di.dart';
import 'package:take_a_walk_app/views/bloc_container.dart';
import 'package:take_a_walk_app/widget/app_button.dart';
import 'package:take_a_walk_app/widget/app_scaffold.dart';
import 'package:take_a_walk_app/widget/loading_dialog.dart';
import 'package:take_a_walk_app/widget/state_dialog.dart';

@RoutePage()
class ProfilePage extends HookWidget {
  const ProfilePage({Key? key}) : super(key: key);

  _onEdit(ProfileBloc bloc, BuildContext context) {
    AutoRouter.of(context).push(const ProfileEditRoute()).then(
        (value) => bloc.getProfileData());
  }

  _onLogOut(BuildContext context) {
    BlocProvider.of<ProfileBloc>(context).logOut();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = useMemoized<ProfileBloc>(() => di());
    useEffect(() {
      bloc.getProfileData();
      bloc.loadingStream.listen((event) {
        if (event) {
          showDialog(context: context, builder: (context) => const LoadingDialog(loadingText: "Signing out"));
        } else {
          Navigator.of(context).pop();
        }
      });
      return null;
    }, const []);
    return AppScaffold(
      appBar: AppBar(
        title: Text("Profile", style: Theme.of(context).textTheme.bodyMedium),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () => _onEdit(bloc, context), icon: const Icon(Icons.edit))
        ],
      ),
      navigationIndex: 3,
      child: BlocProvider<ProfileBloc>(
        create: (context) => bloc,
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoadingState) {
              return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    CircularProgressIndicator(),
                    SizedBox(height: 10),
                  ],
                ),
              );
            }
            if (state is ProfileErrorState) {
              return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Could not load profile data",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 10),
                    AppButton.gradient(
                      child: Text("Try again",
                          style: Theme.of(context).textTheme.bodyMedium),
                      onPressed: () => bloc.getProfileData(),
                    )
                  ],
                ),
              );
            }
            if (state is ProfileDataState) {
              if (state.logoutState != null) {
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  if (state.logoutState!) {
                    AutoRouter.of(context)
                      ..popUntilRoot()
                      ..push(const LoginRoute());
                  } else {
                    showStateDialog(
                        context: context,
                        text: "Could not log out",
                        isSuccess: false,
                        closeOnConfirm: true);
                  }
                });
              }
            }
            return SafeArea(
              child: Scaffold(
                body: Padding(
                  padding: const EdgeInsets.only(
                      top: 10, bottom: 10, right: 10, left: 10),
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
                                      top: 60, left: 10, right: 10),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        (state as ProfileDataState)
                                            .profileData
                                            .username,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.copyWith(
                                                fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      if (state.profileData.bio != null)
                                        Text(
                                          // 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                                          // 'This is my profile description with my info, my interests but most importantly, I am just interested in how it is going to fit inside this card',
                                          state.profileData.bio!,
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
                                          children: [
                                            const Icon(
                                              Icons.mail_outline,
                                              size: 35,
                                            ),
                                            const SizedBox(width: 10),
                                            Text(
                                                // 'kenji_matej@gmail.com'
                                                // (state as ProfileDataState).email
                                                state.profileData.email)
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topCenter,
                              child: SizedBox(
                                width: 100,
                                height: 100,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: state.profileData.image != null &&
                                          state.profileData.image!.isNotEmpty
                                      ? Image.network(
                                          bloc.getImageUrl(
                                              state.profileData.image!),
                                          headers: bloc.getHeaders(),
                                          fit: BoxFit.cover,
                                        )
                                      : const Icon(Icons.account_circle,
                                          size: 100),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: InkWell(
                          onTap: () {
                            AppSettings.openNotificationSettings();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10),
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
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      AppButton.gradient(
                          child: Text("Logout", style: Theme.of(context).textTheme.bodyMedium),
                          onPressed: () => _onLogOut(context),
                      )
                    ],
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
