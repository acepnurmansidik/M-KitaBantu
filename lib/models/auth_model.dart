class AuthModel {
  final String token;
  final String refreshToken;

  AuthModel({required this.token, required this.refreshToken});

  factory AuthModel.fromJSON(Map<String, dynamic> json) {
    return AuthModel(token: json['token'], refreshToken: json['refreshToken']);
  }
}

class Data {
  final String email;
  final String role;

  Data({required this.email, required this.role});
}

class AuthDataModel {
  final String token;
  final bool onboard;
  final Data? data;

  AuthDataModel({required this.token, this.onboard = false, this.data});
}
