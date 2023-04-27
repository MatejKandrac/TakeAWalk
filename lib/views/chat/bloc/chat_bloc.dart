import 'package:either_dart/either.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:take_a_walk_app/domain/repositories/auth_repository.dart';
import 'package:take_a_walk_app/domain/repositories/chats_repository.dart';
import 'package:take_a_walk_app/utils/messaging_service.dart';

import '../../../domain/models/responses/chat_response.dart';

part 'chat_state.dart';

class ChatBloc extends Cubit<ChatState> {
  final AuthRepository authRepository;
  final ChatsRepository repository;
  final MessagingService messagingService;

  ChatBloc(this.repository, this.authRepository, this.messagingService) : super(ChatDataState.empty());

  List<MessageObj> messages = [];
  int currentUserId = -1;

  bool _onCloudNotification(int eventId, RemoteMessage message) {
    // print(message.data);
    // print(eventId);

    print('toto sa zavolalo');
    if (eventId == int.parse(message.data['event_id']) && message.data['message'] != null) {

      print('som v i-fe');

      var userId = int.parse(message.data['message_userId']);


      // TODO create message and emit new state
      var newMessage = MessageObj(
          id: int.parse(message.data['message_id']),
          message: message.data['message'],
          sent: DateTime.parse(message.data['message_sent']),
          username: message.data['message_username'],
          userId: userId
      );


      messages.add(newMessage);

      messages.forEach((element) {print(element.toString());});

      // emit(ChatNewMessageState(messages: messages, userId: userId));
      emitNewMessage(messages, userId);

      return false;
    }
    return true;
  }

  void getMessageData(int eventId, int pageNumber) async {
    messagingService.registerListener((p0) => _onCloudNotification(eventId, p0));

    var userId = await authRepository.getUserId();
    currentUserId = userId!;
    // var userId = 1;

    repository.getEventMessages(eventId, pageNumber).fold((error) => () {}, (data) async {
      messages = data;
      emit(ChatDataState(messages: data, userId: userId!));
      print(data.toList());
    });
  }

  void sendEventMessage(int eventId, String message, int pageNumber) async {
    if (message.isEmpty) {
      return;
    }

    repository.postEventMessage(eventId, message).fold((left) => null, (right) {
      messages.add(MessageObj(id: right, message: message, sent: DateTime.now(), username: '', userId: currentUserId));
      emit(ChatDataState(messages: messages, userId: currentUserId));
    });
  }

  void loadMoreMessages(int eventId, int pageNumber) async {
    repository.getEventMessages(eventId, pageNumber).fold((error) => () {}, (data) async {
      messages = data + messages;
      emit(ChatDataState(messages: messages, userId: currentUserId));
    });
  }

  void emitNewMessage(List<MessageObj> messages, int userId) async {
    emit(ChatDataState(messages: messages, userId: userId));
  }

  dispose() {
    print("Disposing");
    messagingService.removeListener();
  }
}
