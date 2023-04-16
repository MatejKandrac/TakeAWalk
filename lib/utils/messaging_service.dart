

import 'package:either_dart/either.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:take_a_walk_app/domain/repositories/auth_repository.dart';

class MessagingService {

  final AuthRepository _authRepository;

  const MessagingService(this._authRepository);

  registerDeviceToken() async {
    final fcmToken = await FirebaseMessaging.instance.getToken();
    final id = await _authRepository.getUserId();
    if (id == null || fcmToken == null) {
      print("No user id or device token, skipping subscribe to messaging");
      return;
    }

    _authRepository.sendDeviceToken(id, fcmToken).fold(
      (left) => print("failed to subscribe: ${left.getErrorText()}"),
      (right) {
        print("Sucessfully subcsribed");
        FirebaseMessaging.onMessage.listen((event) {
          print("OnMessage: ${event.data}");
        });
        FirebaseMessaging.onMessageOpenedApp.listen((event) {
          print("OnOpenedMessage ${event.data}");
        });
      },
    );
  }

}