class MessageData {
  final String message;
  final int userId;

  MessageData({
    required this.message,
    required this.userId,
});

  Map<String, dynamic> toMap() {
    return {
      'message': this.message,
      'userId': this.userId,
    };
  }

  factory MessageData.fromMap(Map<String, dynamic> map) {
    return MessageData(
      message: map['message'] as String,
      userId: map['userId'] as int,
    );
  }

}