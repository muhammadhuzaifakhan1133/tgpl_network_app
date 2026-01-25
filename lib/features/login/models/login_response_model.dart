// {
//     "access_token": "ZI-AL-Pv8eqdMBgYg35052Cp_3BMWEAwGQ_J1cVZLK77KWQDNDQVTgnqww9Gf6tbPyosu89VZkchFxQBzcCXy9IpRPm5K_aQiXu8hURqzeH8QjhVC7G4m0Sm0taW_7ZlEsrgurxDuwAS2jIZGbYFdWnLdJR_BEEeohMO7ZNF0DNgeffch0wa3FVh5YW_yqZRJZIo7gRjz6sG3GJ2mLO4KeTlJt2ToEmcYc9AGNiyvBDQbhdX5PXw7rBaxOAZM8oe",
//     "token_type": "bearer",
//     "expires_in": 31535999,
//     "Id": "25",
//     "Name": "NP",
//     "userName": "Basit",
//     ".issued": "Tue, 20 Jan 2026 10:36:07 GMT",
//     ".expires": "Wed, 20 Jan 2027 10:36:07 GMT"
// }

class LoginResponseModel {
  final String accessToken;
  final String tokenType;
  final int expiresIn;
  final String id;
  final String name;
  final String userName;
  final String issued;
  final String expires;

  LoginResponseModel({
    required this.accessToken,
    required this.tokenType,
    required this.expiresIn,
    required this.id,
    required this.name,
    required this.userName,
    required this.issued,
    required this.expires,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      accessToken: json['access_token'],
      tokenType: json['token_type'],
      expiresIn: json['expires_in'],
      id: json['Id'],
      name: json['Name'],
      userName: json['userName'],
      issued: json['.issued'],
      expires: json['.expires'],
    );
  }
}