part of 'profile_bloc.dart';

abstract class ProfileState {

  const ProfileState();
}

class ProfileLoadingState extends ProfileState {
  const ProfileLoadingState();
}

class ProfileDataState extends ProfileState {

  final ProfileResponse profileData;
  final bool? logoutState;

  const ProfileDataState({required this.profileData, this.logoutState});
}

class ProfileErrorState extends ProfileState {
  const ProfileErrorState();
}