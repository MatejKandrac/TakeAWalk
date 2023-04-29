
part of 'profile_edit_bloc.dart';

class ProfileEditState {
  final bool passwordError;
  final bool pictureError;
  final bool success;
  final bool failed;
  final File? selectedImage;

  const ProfileEditState({
    this.selectedImage,
    this.failed = false,
    this.passwordError = false,
    this.pictureError = false,
    this.success = false
});
}
