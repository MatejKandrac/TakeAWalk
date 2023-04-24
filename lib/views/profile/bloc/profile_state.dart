part of 'profile_bloc.dart';

abstract class ProfileState {

  const ProfileState();
}


class ProfileFormState extends ProfileState {
  bool usernameError = false;
  bool passwordError = false;

  ProfileFormState(this.usernameError, this.passwordError);
}

// class ProfileDataState extends ProfileState {
//   final String username;
//   final String email;
//   final String? bio;
//   final String? image;
//
//   const ProfileDataState({
//     required this.username,
//     required this.email,
//     this.bio,
//     this.image});
//
//   factory ProfileDataState.empty() => const ProfileDataState(username: "", email: "");
// }

class ProfileDataState extends ProfileState {

  final ProfileResponse profileData;

  const ProfileDataState({required this.profileData});

  factory ProfileDataState.empty() => const ProfileDataState(profileData: ProfileResponse(username: "", email: ""));
}
