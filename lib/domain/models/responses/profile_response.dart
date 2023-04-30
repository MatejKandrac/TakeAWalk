
class ProfileResponse {
  final String username;
  final String email;
  final String? bio;
  final String? image;

  const ProfileResponse({
    required this.username,
    required this.email,
    this.bio,
    this.image,
  });

  factory ProfileResponse.fromMap(Map<String, dynamic> map) {
    return ProfileResponse(
      username: map['userName'] as String,
      email: map['email'] as String,
      bio: map['bio'] as String?,
      image: map['profilePicture'] as String?,
    );
  }
}