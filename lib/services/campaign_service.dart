import 'dart:convert';
import 'dart:io';

import 'package:kitabantu/models/campaign_model.dart';
import 'package:http/http.dart' as http;
import 'package:kitabantu/services/auth_service.dart';

class CampaignService {
  final String baseUrl = "http://10.0.2.2:3022/api/v1";

  Future<List> getCampaigns(
      {category = "", fastHelp = false, limit = 10}) async {
    try {
      final response = await http.get(Uri.parse(
          '$baseUrl/campaign/?page=1&limit=$limit&fast_help=$fastHelp&slug=$category'));
      final data = json.decode(response.body);

      List<dynamic> campaigns = await data["data"]
          .map((campaign) => CampaignModel.fromJson(campaign))
          .toList();

      return campaigns;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> postDonateCampaign(DonateCampaignModel body) async {
    try {
      final headers = await AuthService().authTokenHeaders("json");
      final response = await http.post(
        Uri.parse('$baseUrl/campaign/donate'),
        body: body.toJSON(),
        headers: headers,
      );

      final data = json.decode(response.body);

      if (data["code"] >= 400) {
        throw HttpException(data["message"]);
      }
    } catch (e) {
      rethrow;
    }
  }
}
