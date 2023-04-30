import 'package:take_a_walk_app/domain/models/responses/profile_response.dart';
import 'package:take_a_walk_app/utils/persistence/app_database.dart';

import '../../../utils/persistence/entities/profile.dart';

class ProfileLocalService {
  final AppDatabase database;

  ProfileLocalService(this.database);

  Future<ProfileResponse> getProfile(int userId) async {

    final profileDao = database.profileDao;

    var profileData = await profileDao.findProfileById(userId);

    if (profileData != null) {
      return ProfileResponse(
          username: profileData.username,
          email: profileData.email,
          bio: profileData.bio,
          image: profileData.profilePicture);
    } else {
      return const ProfileResponse(username: '', email: '', bio: '', image: '');
    }
  }

  void saveProfile(ProfileResponse profileData, int userId) {

    var profile = Profile(
        id: userId,
        email: profileData.email,
        username: profileData.username,
        bio: profileData.bio,
        profilePicture: profileData.image);

    final profileDao = database.profileDao;

    profileDao.insertProfile(profile);
  }

  void updateProfile(int userId, ProfileResponse profileData) {

    final profileDao = database.profileDao;

    profileDao.updateProfile(userId, profileData.username, profileData.email, profileData.bio ?? '', profileData.image ?? '');
  }

  Future<bool> isPresent(int id) async {

    final profileDao = database.profileDao;

    var profile = await profileDao.findProfileById(id);

    if (profile != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> deleteDatabase() async {
    database.database.delete('Profile');
    database.database.delete('Event');
  }

}
