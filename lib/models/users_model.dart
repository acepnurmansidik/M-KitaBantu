class RegisterModel {
  String email;
  String password;
  String deviceToken;
  String username;

  RegisterModel({
    required this.email,
    required this.password,
    required this.deviceToken,
    required this.username,
  });

  factory RegisterModel.fromJSON(Map<String, dynamic> json) {
    return RegisterModel(
      email: json['email'],
      password: json['password'],
      deviceToken: json['device_token'],
      username: json['username'],
    );
  }

  Map<String, dynamic> toJSON() {
    return {
      "email": email,
      "password": password,
      "username": username,
      "device_token": deviceToken
    };
  }
}

class LoginModel {
  final String email;
  final String password;
  final String deviceToken;

  LoginModel({
    required this.email,
    required this.password,
    required this.deviceToken,
  });

  factory LoginModel.fromJSON(Map<String, dynamic> json) {
    return LoginModel(
      email: json['email'],
      password: json['password'],
      deviceToken: json['device_token'],
    );
  }

  Map<String, dynamic> toJSON() {
    return {
      "email": email,
      "password": password,
      "device_token": deviceToken,
    };
  }
}
