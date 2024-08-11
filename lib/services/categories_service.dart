import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kitabantu/models/category_model.dart';

class CategoriesService {
  final String baseUrl = "http://10.0.2.2:3022/api/v1";

  Future<List> getCategories() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/category'));
      final data = json.decode(response.body);

      List<dynamic> categories = await data["data"]
          .map((category) => CategoryModel.fromJson(category))
          .toList();

      return categories;
    } catch (e) {
      rethrow;
    }
  }
}
