import 'package:floor/floor.dart';

import '../entities/profile.dart';

@dao
abstract class ProfileDao {

  @Query('SELECT * FROM Profile WHERE id = :id')
  Future<Profile?> findProfileById(int id);

  @Query('UPDATE PROFILE SET id = :id, username = :username, email = :email, bio = :bio, profilePicture = :profilePicture WHERE id = :id')
  Future<void> updateProfile(int id, String username, String email, String bio, String profilePicture);

  @insert
  Future<void> insertProfile(Profile profile);

}