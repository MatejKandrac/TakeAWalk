import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../widget/app_scaffold.dart';

@RoutePage()
class ChatPage extends HookWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final messageController = useTextEditingController();
    return AppScaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text("Chat", style: Theme.of(context).textTheme.bodyMedium),
      ),
      navigationIndex: 0,
      child: SafeArea(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(10),
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: const [
                      Message(),
                      Message(),
                      MyMessage(),
                      Message(),
                      Message(),
                      MyMessage(),
                      Message(),
                      MyMessage(),
                      Message(),
                      MyMessage(),
                      Message(),
                      MyMessage(),
                      Message(),
                    ],
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
                            onPressed: () {},
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
  }
}

class Message extends HookWidget {
  const Message({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.only(top: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Username',
            style: TextStyle(fontSize: 15),
          ),
          Row(
            children: [
              const Icon(Icons.account_circle, size: 30),
              const SizedBox(width: 5),
              Container(
                width: 200,
                child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  color: const Color(0xD9D9D9FF),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: const [
                        Text(
                          'Actual longer message Actual longer message Actual longer message',
                          softWrap: true,
                          style: TextStyle(
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
  const MyMessage({Key? key}) : super(key: key);

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
        child: const Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            'This is my message This is my message This is my message This is my message This is my message',
            style: TextStyle(
              fontSize: 15,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
