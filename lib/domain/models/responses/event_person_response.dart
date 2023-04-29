
class EventPersonResponse {

  final int? id;
  final String status;
  final String username;
  final String? picture;

  const EventPersonResponse({
    required this.status,
    required this.username,
    this.id,
    this.picture,
  });

  Map<String, dynamic> toMap() {
    return {
      'status': this.status,
      'username': this.username,
      'picture': this.picture,
    };
  }

  factory EventPersonResponse.fromMap(Map<String, dynamic> map) {
    return EventPersonResponse(
      status: map['status'] as String,
      username: map['username'] as String,
      picture: map['picture'] as String?,
    );
  }

}