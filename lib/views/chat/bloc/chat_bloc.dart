
import 'package:either_dart/either.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:take_a_walk_app/domain/repositories/auth_repository.dart';
import 'package:take_a_walk_app/domain/repositories/chats_repository.dart';

import '../../../domain/models/responses/chat_response.dart';

part 'chat_state.dart';

class ChatBloc extends Cubit<ChatState> {
  final AuthRepository authRepository;
  final ChatsRepository repository;

  ChatBloc(this.repository, this.authRepository) : super(ChatDataState.empty());

  List<MessageObj> messages = [];
  int currentUserId = -1;

  void getMessageData(int eventId, int pageNumber) async {

    var userId = await authRepository.getUserId();
    currentUserId = userId!;
    // var userId = 1;

    repository.getEventMessages(eventId, pageNumber).fold((error) => () {}, (data) async {
      messages = data;
      emit(ChatDataState(messages: data, userId: userId!));
      print(data.toList());
    });
  }

  void sendEventMessage(int eventId, String message) async {

    if (message.isEmpty) {
      return;
    }

    repository.postEventMessage(eventId, message);
  }

  void loadMoreMessages(int eventId, int pageNumber) async {
    repository.getEventMessages(eventId, pageNumber).fold((error) => (){print('error nejaky');}, (data) async {
      messages = data + messages;
      print(messages.toList());
      emit(ChatDataState(messages: messages, userId: currentUserId));
    });
  }

}