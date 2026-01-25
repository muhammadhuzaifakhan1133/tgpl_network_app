
class LoginRequestModel {
  final String username;
  final String password;
  final String grantType;

  LoginRequestModel({
    required this.username,
    required this.password,
    this.grantType = 'password',
  });

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
      'grant_type': grantType,
    };
  }
}