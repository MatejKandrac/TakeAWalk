
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:take_a_walk_app/config/constants.dart';

class AuthLocalService {
  
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  
  Future<bool> persistData(String token, String refreshToken) async {
    try {
      _storage.write(key: AppConstants.storageKeyToken, value: token);
      _storage.write(key: AppConstants.storageKeyRefreshToken, value: refreshToken);
      _storage.write(key: AppConstants.storageKeyUserId, value: JwtDecoder.decode(token)['userId']);
    } catch (e, stacktrace) {
      print(e);
      print(stacktrace);
      return false;
    }
    return true;
  }

  Future<String?> getToken() async {
    try {
      return _storage.read(key: AppConstants.storageKeyToken);
    } catch (e, stacktrace) {
      print(e);
      print(stacktrace);
    }
    return null;
  }

  Future<int?> getUserId() async {
    try {
      String? data = await _storage.read(key: AppConstants.storageKeyUserId);
      if (data == null) {
        return null;
      } else {
        return int.parse(data);
      }
    } catch (e, stacktrace) {
      print(e);
      print(stacktrace);
    }
    return null;
  }
  
}