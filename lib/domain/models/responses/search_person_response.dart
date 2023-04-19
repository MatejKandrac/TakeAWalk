
class SearchPersonResponse {

  final int id;
  final String username;
  final String? picture;
  final String email;
  final String? bio;

  const SearchPersonResponse({
    required this.username,
    required this.email,
    required this.id,
    this.picture,
    this.bio,
  });
  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'username': this.username,
      'picture': this.picture,
      'email': this.email,
      'bio': this.bio,
    };
  }

  factory SearchPersonResponse.fromMap(Map<String, dynamic> map) {
    return SearchPersonResponse(
      id: map['id'] as int,
      username: map['userName'] as String,
      picture: map['profilePicture'] as String?,
      email: map['email'] as String,
      bio: map['bio'] as String?,
    );
  }
}