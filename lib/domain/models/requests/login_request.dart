
class LoginRequest {

  final String email;
  final String password;

  const LoginRequest({
    required this.email,
    required this.password,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LoginRequest &&
          runtimeType == other.runtimeType &&
          email == other.email &&
          password == other.password);

  @override
  int get hashCode => email.hashCode ^ password.hashCode;

  @override
  String toString() {
    return 'LoginRequest{' +
        ' email: $email,' +
        ' password: $password,' +
        '}';
  }

  LoginRequest copyWith({
    String? username,
    String? password,
  }) {
    return LoginRequest(
      email: username ?? this.email,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': this.email,
      'password': this.password,
    };
  }

  factory LoginRequest.fromMap(Map<String, dynamic> map) {
    return LoginRequest(
      email: map['username'] as String,
      password: map['password'] as String,
    );
  }

}