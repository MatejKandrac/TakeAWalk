import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:take_a_walk_app/views/bloc_container.dart';

import '../../domain/models/responses/chat_response.dart';

@RoutePage()
class ChatPage extends HookWidget {
  ChatPage({Key? key, required this.eventId}) : super(key: key);

  final int eventId;

  int pageNumber = 0;

  _loadMessages(BuildContext context) {
    pageNumber += 1;
    BlocProvider.of<ChatBloc>(context).loadMoreMessages(eventId, pageNumber);
    print('Load more messages');
  }

  _onSendMessage(BuildContext context, String message) {
    BlocProvider.of<ChatBloc>(context).sendEventMessage(eventId, message);
  }

  @override
  Widget build(BuildContext context) {
    final messageController = useTextEditingController();
    final bloc = useMemoized<ChatBloc>(() => BlocProvider.of(context));
    useEffect(() {
      bloc.getMessageData(eventId, pageNumber);
      return null;
    }, const []);
    return BlocListener<ChatBloc, ChatState>(
      listener: (context, state) {
        // if (state is ProfileFormState) {
        //   _getProfileData(context);
        // }
      },
      child: BlocBuilder<ChatBloc, ChatState>(
        buildWhen: (previous, current) => current is ChatDataState,
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: true,
              title: Text("Chat", style: Theme.of(context).textTheme.bodyMedium),
            ),
            body: SafeArea(
              child: Scaffold(
                body: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: SingleChildScrollView(
                          // controller: _controller,

                          scrollDirection: Axis.vertical,
                          reverse: true,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Align(
                                alignment: Alignment.topCenter,
                                child: IconButton(onPressed: () => _loadMessages(context), icon: const Icon(Icons.refresh)),
                              ),
                              for (var data in state.messages)
                                if (data.userId == state.userId)
                                  MyMessage(message: data.message)
                                else
                                  Message(username: data.username, message: data.message),

                              // Message(username: 'Tester1', message: 'first message'),
                              // MyMessage(message: 'My message'),
                              // Message(username: 'Tester2', message: 'second message'),
                              // MyMessage(message: 'My message'),
                              // MyMessage(message: 'My message'),
                              // Message(username: 'Tester2', message: 'second message'),
                              // MyMessage(message: 'My message'),
                              // MyMessage(message: 'My message'),
                              // Message(username: 'Tester2', message: 'second message'),
                              // MyMessage(message: 'My message'),
                              // MyMessage(message: 'My message'),
                              // Message(username: 'Tester2', message: 'second message'),
                              // MyMessage(message: 'My message'),
                              // MyMessage(message: 'My message'),

                              const SizedBox(
                                height: 100,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          color: Colors.white,
                          elevation: 10,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10, left: 10),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    style: const TextStyle(color: Colors.black),
                                    controller: messageController,
                                    decoration: const InputDecoration(
                                      labelText: 'Enter message',
                                      labelStyle: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ),
                                // Spacer(),
                                const SizedBox(
                                  width: 10,
                                ),
                                IconButton(
                                  onPressed: () => _onSendMessage(context, messageController.text),
                                  icon: const Icon(
                                    Icons.send_outlined,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class Message extends HookWidget {
  const Message({Key? key, required this.username, required this.message, this.profilePicture}) : super(key: key);

  final String username;
  final String message;
  final String? profilePicture;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.only(top: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            username,
            style: const TextStyle(fontSize: 15),
          ),
          Row(
            children: [
              const Icon(Icons.account_circle, size: 30), // add profile picture
              const SizedBox(width: 5),
              Container(
                width: 200,
                alignment: Alignment.bottomLeft,
                child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  color: const Color(0xD9D9D9FF),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Text(
                          message,
                          softWrap: true,
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class MyMessage extends HookWidget {
  const MyMessage({Key? key, required this.message}) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      margin: const EdgeInsets.only(top: 10),
      alignment: Alignment.centerRight,
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        color: const Color(0xD9D9D9FF),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            message,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
