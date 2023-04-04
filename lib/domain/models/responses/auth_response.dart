
class AuthResponse {

  final String token;
  final String refreshToken;

  const AuthResponse({
    required this.token,
    required this.refreshToken,
  });

  factory AuthResponse.fromMap(Map<String, dynamic> map) {
    return AuthResponse(
      token: map['token'] as String,
      refreshToken: map['refreshToken'] as String,
    );
  }

}