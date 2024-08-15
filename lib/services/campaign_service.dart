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
        body: {
          "campaign_name":
              "Peduli Sesama Untuk Kaum Yang Penderita Kanker Dompet",
          "slug_name": "peduli-sesama-untuk-kaum-yang-penderita-kanker-dompet",
          "amount": 2430000,
          "nominal": 72000,
          "description": "diperlukan untuk keberlangsungan hidup makhluk hidup",
          "organizer_id": "16bf705c-449d-428f-9a21-aa9d3c7a430c",
          "campaign_id": "d1f2df59-d492-4c27-8718-263e3b1fd4e0",
          "bank": {
            "bank_name": "ABS",
            "bank_code": "073",
            "account_name": "asep bandung",
            "account_number": "177223472375472"
          },
          "comment": {"name": "asep", "comment": "woereoreroeore"}
        },
      );
      print(response.body);

      final data = json.decode(response.body);

      if (data["code"] >= 400) {
        throw HttpException(data["message"]);
      }
    } catch (e) {
      rethrow;
    }
  }
}
