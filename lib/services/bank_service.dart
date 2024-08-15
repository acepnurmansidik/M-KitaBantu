import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kitabantu/models/bank_model.dart';

class BankService {
  final String baseUrl = "http://10.0.2.2:3022/api/v1";

  Future<List> getBanks() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/bank'));
      final data = json.decode(response.body);

      final banks =
          await data["data"].map((bank) => BankModel.fromJson(bank)).toList();

      return banks;
    } catch (e) {
      rethrow;
    }
  }
}
