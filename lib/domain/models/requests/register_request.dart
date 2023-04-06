
class RegisterRequest {

  final String email;
  final String username;
  final String password;

  RegisterRequest({
    required this.email,
    required this.username,
    required this.password
  });

  Map<String, dynamic> toMap() {
    return {
      'email': this.email,
      'username': this.username,
      'password': this.password,
    };
  }

  factory RegisterRequest.fromMap(Map<String, dynamic> map) {
    return RegisterRequest(
      email: map['email'] as String,
      username: map['username'] as String,
      password: map['password'] as String,
    );
  }
}