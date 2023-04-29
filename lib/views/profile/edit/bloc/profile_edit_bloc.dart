
import 'dart:io';

import 'package:either_dart/either.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rxdart/rxdart.dart';
import 'package:take_a_walk_app/domain/models/requests/profile_edit_request.dart';
import 'package:take_a_walk_app/domain/repositories/users_repository.dart';

part 'profile_edit_state.dart';

class ProfileEditBloc extends Cubit<ProfileEditState> {
  ProfileEditBloc(this._repository) : super(const ProfileEditState());

  final BehaviorSubject<bool> _loadingDialogController = BehaviorSubject();

  Stream<bool> get loadingStream => _loadingDialogController.stream;

  final UsersRepository _repository;
  File? _selectedFile;

  void editProfileData(String newUsername, String newPassword, String confirmPassword, String newBio) async {
    if (newPassword != confirmPassword) {
      emit(ProfileEditState(passwordError: true, selectedImage: _selectedFile));
      return;
    }
    _loadingDialogController.sink.add(true);
    String? newUsernameCheck = newUsername.isEmpty ? null : newUsername;
    String? newPasswordCheck = newPassword.isEmpty ? null : newPassword;
    String? newBioCheck = newBio.isEmpty ? null : newBio;

    ProfileEditRequest request = ProfileEditRequest(username: newUsernameCheck, password: newPasswordCheck, bio: newBioCheck);

    await _repository.editUserProfile(request).fold(
      (left) => emit(ProfileEditState(failed: true, selectedImage: _selectedFile)),
      (right) async {
        if (_selectedFile != null){
          var result = await _repository.updateProfileImage(_selectedFile!);
          if (result != null) {
            emit(ProfileEditState(pictureError: true, selectedImage: _selectedFile));
          }
          else {
            emit(ProfileEditState(success: true, selectedImage: _selectedFile));
          }
        } else {
          emit(ProfileEditState(success: true, selectedImage: _selectedFile));
        }
      },
    );

    _loadingDialogController.sink.add(false);
  }


  void updateImage(bool isGallery) async {
    final picker = ImagePicker();
    XFile? file = await picker.pickImage(source: isGallery ? ImageSource.gallery : ImageSource.camera);
    if (file != null) {
      _selectedFile = File(file.path);
      emit(ProfileEditState(selectedImage: _selectedFile));
    }
  }

}