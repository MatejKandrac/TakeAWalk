import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/src/response.dart';
import 'package:retrofit/dio.dart';
import 'package:take_a_walk_app/domain/models/responses/profile_response.dart';
import 'package:take_a_walk_app/utils/persistence/app_database.dart';

import '../../../utils/persistence/entities/profile.dart';

class ProfileLocalService {
  final AppDatabase database;

  ProfileLocalService(this.database);

  Future<ProfileResponse> getProfile(int userId) async {
    print('Getting profile data from SQLite');

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

    // return const ProfileResponse(username: 'test123', email: 'test123', bio: 'test123', image: 'test123');
  }

  void saveProfile(ProfileResponse profileData, int userId) {

    print('Saving profile');

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
    print('Updating profile');

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
}
