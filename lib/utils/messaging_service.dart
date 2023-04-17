

import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:take_a_walk_app/domain/repositories/auth_repository.dart';

class MessagingService {

  final AuthRepository _authRepository;

  const MessagingService(this._authRepository);

  registerDeviceToken() async {
    if (Platform.isAndroid) {
      final fcmToken = await FirebaseMessaging.instance.getToken();
      final id = await _authRepository.getUserId();
      if (id == null || fcmToken == null) {
        print("No user id or device token, skipping subscribe to messaging");
        return;
      }

      var result = await _authRepository.sendDeviceToken(id, fcmToken);
      if (result == null) {
        print("Sucessfully subcsribed");
        FirebaseMessaging.onMessage.listen((event) {
          print("OnMessage: ${event.data}");
        });
        FirebaseMessaging.onMessageOpenedApp.listen((event) {
          print("OnOpenedMessage ${event.data}");
        });
      } else {
        print("failed to subscribe: ${result.getErrorText()}");
      }
    } else {
      print("Could not register token for notifications. This is not a supported platform");
    }
  }
}