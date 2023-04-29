
part of 'chat_bloc.dart';

abstract class ChatState {
  final int userId;
  final List<MessageObj> messages;

  const ChatState(this.messages, this.userId);
}

class ChatDataState extends ChatState {

  const ChatDataState(super.messages, super.userId);

  factory ChatDataState.empty() => const ChatDataState([], -1);

}

class ChatNewMessageState extends ChatState {

  const ChatNewMessageState(super.messages, super.userId);

  factory ChatNewMessageState.empty() => const ChatNewMessageState([], -1);

}

class ChatErrorState extends ChatState {
  final String errorText;

  ChatErrorState(super.messages, super.userId, this.errorText);


}