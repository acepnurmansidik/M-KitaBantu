import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:kitabantu/models/auth_model.dart';
import 'package:kitabantu/models/users_model.dart';
import 'package:kitabantu/services/auth_service.dart';

class UsersService extends AuthService {
  final String baseUrl = "http://10.0.2.2:3022/api/v1";

  Future<void> authRegister(RegisterModel body) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/sign-up'),
        body: body.toJSON(),
      );

      final data = json.decode(response.body);

      if (data["code"] >= 400) {
        throw HttpException(data["message"]);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> authLogin(LoginModel body) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/sign-in'),
        body: body.toJSON(),
      );
      final data = json.decode(response.body);

      AuthModel result = AuthModel.fromJSON(data["data"]);
      await saveToken(result.token);

      if (data["code"] >= 400) {
        throw HttpException(data["message"]);
      }
    } catch (e) {
      rethrow;
    }
  }
}
