
class MessageObj {
  final int id;
  final String message;
  final DateTime sent;
  final String username;
  final int userId;
  final String? profilePicture;

  const MessageObj({
    required this.id,
    required this.message,
    required this.sent,
    required this.username,
    required this.userId,
    this.profilePicture,
  });

  factory MessageObj.fromMap(Map<String, dynamic> map) {
    return MessageObj(
      id: map['id'] as int,
      message: map['message'] as String,
      sent: DateTime.parse(map['sent'] as String).toLocal(),
      username: map['userName'] as String,
      userId: map['userId'] as int,
      profilePicture: map['profilePicture'] as String?,
    );
  }

}
