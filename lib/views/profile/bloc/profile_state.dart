part of 'profile_bloc.dart';

abstract class ProfileState {
  const ProfileState();
}

class ProfileDataState extends ProfileState {
  final String username;
  final String email;
  final String? bio;
  final String? image;

  const ProfileDataState(this.username, this.email, this.bio, this.image);
}
