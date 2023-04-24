
part of 'chat_bloc.dart';

abstract class ChatState {
  final int userId;
  final List<MessageObj> messages;

  const ChatState(this.messages, this.userId);
}

class ChatDataState extends ChatState {

  @override
  final int userId;

  @override
  final List<MessageObj> messages;

  const ChatDataState({required this.messages, required this.userId}) : super(messages, userId);

  factory ChatDataState.empty() => ChatDataState(messages: [MessageObj(id: -1, message: '', sent: DateTime.now(), username: '', userId: -1)], userId: -1);

}