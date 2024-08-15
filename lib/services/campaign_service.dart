import 'dart:convert';
import 'dart:io';

import 'package:kitabantu/models/campaign_model.dart';
import 'package:http/http.dart' as http;

class CampaignService {
  final String baseUrl = "http://10.0.2.2:3022/api/v1";

  Future<List> getCampaigns() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/campaign/'));
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
      final response = await http.post(
        Uri.parse('$baseUrl/campaign/donate'),
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
}
