class MessageObj {
  final int id;
  final String message;
  final DateTime sent;
  final String username;
  final String? profilePicture;

  const MessageObj({
    required this.id,
    required this.message,
    required this.sent,
    required this.username,
    this.profilePicture,
  });

  factory MessageObj.fromMap(Map<String, dynamic> map) {
    return MessageObj(
      id: map['id'] as int,
      message: map['message'] as String,
      sent: map['sent'] as DateTime,
      username: map['username'] as String,
      profilePicture: map['profilePicture'] as String?,
    );
  }

}
