
class AuthResponse {

  final String token;
  final String refreshToken;

  const AuthResponse({
    required this.token,
    required this.refreshToken,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AuthResponse &&
          runtimeType == other.runtimeType &&
          token == other.token &&
          refreshToken == other.refreshToken);

  @override
  int get hashCode => token.hashCode ^ refreshToken.hashCode;

  @override
  String toString() {
    return 'AuthResponse{' +
        ' token: $token,' +
        ' refreshToken: $refreshToken,' +
        '}';
  }

  AuthResponse copyWith({
    String? token,
    String? refreshToken,
  }) {
    return AuthResponse(
      token: token ?? this.token,
      refreshToken: refreshToken ?? this.refreshToken,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'token': this.token,
      'refreshToken': this.refreshToken,
    };
  }

  factory AuthResponse.fromMap(Map<String, dynamic> map) {
    return AuthResponse(
      token: map['token'] as String,
      refreshToken: map['refreshToken'] as String,
    );
  }

}