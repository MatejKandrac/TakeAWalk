import 'package:either_dart/either.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:take_a_walk_app/domain/repositories/users_repository.dart';

import '../../../domain/models/requests/profile_edit_request.dart';

part 'profile_state.dart';

class ProfileBloc extends Cubit<ProfileState> {
  final UsersRepository repository;

  ProfileBloc(this.repository) : super(ProfileDataState.empty());

  void getProfileData() async {
    repository.getProfile().fold((error) => () {}, (data) async {
      emit(ProfileDataState(username: data.username, email: data.email, bio: data.bio, image: data.image));
    });
  }

  void editProfileData(String newUsername, String newPassword, String confirmPassword, String newBio) async {
    if (newPassword != confirmPassword) {
      emit(ProfileFormState(false, true));
      return;
    }

    String? newUsernameCheck = newUsername.isEmpty ? null : newUsername;
    String? newPasswordCheck = newPassword.isEmpty ? null : newPassword;
    String? newBioCheck = newBio.isEmpty ? null : newBio;

    ProfileEditRequest request =
        ProfileEditRequest(username: newUsernameCheck, password: newPasswordCheck, bio: newBioCheck);

    repository.editUserProfile(request);
    getProfileData();
  }

  void emitProfileFormState() async {
    emit(ProfileFormState(false, false));
  }
}
