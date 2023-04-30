import 'package:floor/floor.dart';

@entity
class Profile {

  @primaryKey
  final int id;

  final String username;

  final String email;

  final String? bio;

  final String? profilePicture;

  Profile({
    required this.id,
    required this.username,
    required this.email,
    this.bio,
    this.profilePicture
});

}