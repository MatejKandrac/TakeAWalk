
import 'package:intl/intl.dart';

class AppConstants {

  const AppConstants._();

  static const appName = "TakeAWalk";

  static const baseUrl = "http://192.168.141.205:8080";

  static const storageKeyToken = "TAKEAWALK_TOKEN_KEY";
  static const storageKeyRefreshToken = "TAKEAWALK_REFRESH_TOKEN_KEY";
  static const storageKeyUserId = "TAKEAWALK_USER_ID_KEY";

  static final dateFormat = DateFormat("dd.MM.yyyy");
  static final dateOnlyFormat = DateFormat("dd.MM");
  static final timeFormat = DateFormat("HH:mm");
}

class AppAssets {
  const AppAssets._();

  static const splashText = "assets/splash_text.png";
  static const logoWhite = "assets/icon_white.png";
  static const success = "assets/success.json";
  static const error = "assets/error.json";
}