
class DeviceTokenRequest {

  final String deviceToken;

  const DeviceTokenRequest({
    required this.deviceToken
  });

  Map<String, dynamic> toMap() {
    return {
      'deviceToken': this.deviceToken,
    };
  }

  factory DeviceTokenRequest.fromMap(Map<String, dynamic> map) {
    return DeviceTokenRequest(
      deviceToken: map['deviceToken'] as String,
    );
  }
}