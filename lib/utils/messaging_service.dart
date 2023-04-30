

import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:take_a_walk_app/config/constants.dart';
import 'package:take_a_walk_app/domain/models/requests/device_token_request.dart';
import 'package:take_a_walk_app/domain/repositories/auth_repository.dart';

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  print("Notification tapped");
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  final plugin = FlutterLocalNotificationsPlugin();
  await _initNotifications(plugin, false);
  _showNotification(plugin, message);
}

_initNotifications(FlutterLocalNotificationsPlugin notificationsPlugin, [bool checkPermission = true]) async {

  if (checkPermission) {
    notificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.requestPermission();
  }

  await notificationsPlugin.initialize(
      const InitializationSettings(
          android: AndroidInitializationSettings('icon_white')
      ),
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground
  );
}

_showNotification(FlutterLocalNotificationsPlugin plugin, RemoteMessage message) async {
  bool isEvent = message.data.containsKey('event_id');
  int id = int.parse(message.data['event_id'] ?? message.data['message_id']);

  final details = NotificationDetails(
      android: AndroidNotificationDetails(
        isEvent ? AppConstants.notificationChannelEventsId : AppConstants.notificationChannelMessagesId,
        AppConstants.notificationsChannelEventsName,
        category: AndroidNotificationCategory.event,
      )
  );
  plugin.show(id, message.data['notification_title'], message.data['notification_content'], details);
}

class MessagingService {

  final AuthRepository _authRepository;
  final FlutterLocalNotificationsPlugin notificationsPlugin;
  bool Function(RemoteMessage message)? _onChatMessage;

  MessagingService(this._authRepository, this.notificationsPlugin);

  registerListener(bool Function(RemoteMessage) listener) {
    _onChatMessage = listener;
  }

  removeListener() {
    _onChatMessage = null;
  }

  registerDeviceToken() async {
    if (Platform.isAndroid) {
      FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
      await _initNotifications(notificationsPlugin);
      print("Initializing messaging service");
      FirebaseMessaging.onMessage.listen((event) {
        var showNotification = true;
        print(_onChatMessage.toString());
        print('toto teraz zafungovalo');
        if (_onChatMessage != null) {
          showNotification = _onChatMessage!(event);
        }
        if (showNotification) {
          _showNotification(notificationsPlugin, event);
        }
      });
      // FirebaseMessaging.onMessageOpenedApp.listen((event) => _showNotification(notificationsPlugin, event));
      final fcmToken = await FirebaseMessaging.instance.getToken();
      if (fcmToken != null) {
        _sendDeviceToken(fcmToken);
      }

      FirebaseMessaging.instance.onTokenRefresh.listen((event) {
        _sendDeviceToken(event);
      });

    } else {
      print("Could not register token for notifications. This is not a supported platform");
    }
  }

  _sendDeviceToken(String token) async{
    print("Updating device token");
    var result = await _authRepository.sendDeviceToken(DeviceTokenRequest(deviceToken: token));
    if (result == null) {
      print("Sucessfully subcsribed");

    } else {
      print("failed to subscribe: ${result.getErrorText()}");
    }
  }
}