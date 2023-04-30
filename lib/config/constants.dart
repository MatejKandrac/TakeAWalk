
import 'package:intl/intl.dart';

class AppConstants {

  const AppConstants._();

  static const appName = "TakeAWalk";

  static const baseUrl = "http://192.168.0.10:8080";

  static const storageKeyToken = "TAKEAWALK_TOKEN_KEY";
  static const storageKeyRefreshToken = "TAKEAWALK_REFRESH_TOKEN_KEY";
  static const storageKeyUserId = "TAKEAWALK_USER_ID_KEY";

  static const notificationsChannelEventsName = "Events";
  static const notificationChannelEventsId = "TAKEAWALK_NOTIFICATION_CHANNEL_EVENTS";

  static const notificationChannelMessagesId = "TAKEWAWALK_NOTIFICATION_CHANNEL_MESSAGES";
  static const notificationChannelMessagesName = "Messages";

  static final dateFormat = DateFormat("dd.MM.yyyy");
  static final dateOnlyFormat = DateFormat("dd.MM");
  static final timeFormat = DateFormat("HH:mm");
  static final weatherDateFormat = DateFormat("yyyy-MM-dd");
}

class AppAssets {
  const AppAssets._();

  static const splashText = "assets/splash_text.png";
  static const logoWhite = "assets/icon_white.png";
  static const success = "assets/success.json";
  static const error = "assets/error.json";
  static const question = "assets/question.json";
  static const deleted = "assets/removed.json";
}