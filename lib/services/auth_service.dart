import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:kitabantu/main.dart';
import 'package:kitabantu/models/auth_model.dart';

class AuthService {
  // Create storage
  final storage = const FlutterSecureStorage();

  Future<void> saveToken(String token) async {
    try {
      await storage.write(key: 'token', value: token);
      await storage.write(key: 'onboard', value: 'true');
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteToken() async {
    try {
      await storage.delete(key: 'token');
    } catch (e) {
      rethrow;
    }
  }

  Future<AuthDataModel> getToken() async {
    String? onboard = await storage.read(key: 'onboard');
    try {
      String? token = await storage.read(key: 'token');
      if (token.toString() == "") return AuthDataModel(token: "");

      bool tokenExpired = JwtDecoder.isExpired(token.toString());
      if (tokenExpired) {
        navigatorKey.currentState!
            .pushNamedAndRemoveUntil('/main', (context) => false);
      }

      final payload = JwtDecoder.decode(token.toString());
      AuthDataModel result = AuthDataModel(
        token: token.toString(),
        onboard: onboard.toString() != "" ? true : false,
        data: Data(email: payload['email'], role: payload['role']),
      );

      return result;
    } catch (e) {
      return AuthDataModel(
          token: "", onboard: onboard.toString() != "" ? true : false);
    }
  }
}
