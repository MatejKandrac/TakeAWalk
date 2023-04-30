
class ProfileEditRequest {
  String? password;
  final String? username;
  final String? bio;

  ProfileEditRequest({
    this.password,
    this.username,
    this.bio
  });

  Map<String, dynamic> toMap() {
    return {
      'password': this.password,
      'username': this.username,
      'bio': this.bio,
    };
  }

  factory ProfileEditRequest.fromMap(Map<String, dynamic> map) {
    return ProfileEditRequest(
        password: map['password'] as String,
        username: map['username'] as String,
        bio: map['bio'] as String);
  }
}
