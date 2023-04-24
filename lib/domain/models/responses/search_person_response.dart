
class SearchPersonResponse {

  final int id;
  final String username;
  final String? picture;
  final String? bio;

  const SearchPersonResponse({
    required this.username,
    required this.id,
    this.picture,
    this.bio,
  });
  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'username': this.username,
      'picture': this.picture,
      'bio': this.bio,
    };
  }

  factory SearchPersonResponse.fromMap(Map<String, dynamic> map) {
    return SearchPersonResponse(
      id: map['id'] as int,
      username: map['username'] as String,
      picture: map['picture'] as String?,
      bio: map['bio'] as String?,
    );
  }
}