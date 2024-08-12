class ImagesModel {
  final String? id;
  final String linkUrl;

  ImagesModel({
    required this.id,
    required this.linkUrl,
  });

  factory ImagesModel.fromJson(Map<String, dynamic> json) {
    return ImagesModel(
      id: json['id'],
      linkUrl: json['link_url'],
    );
  }
}

class DonateCampaignModel {
  final String id;
  final String nominal;
  final String date;

  DonateCampaignModel({
    required this.id,
    required this.nominal,
    required this.date,
  });

  factory DonateCampaignModel.fromJson(Map<String, dynamic> json) {
    return DonateCampaignModel(
      id: json['id'],
      nominal: json['nominal'],
      date: json['date'],
    );
  }
}

class CampaignCommentsModel {
  final String id;
  final String name;
  final String comment;
  final String date;
  final bool isAnonymous;

  CampaignCommentsModel({
    required this.id,
    required this.name,
    required this.comment,
    required this.date,
    required this.isAnonymous,
  });

  factory CampaignCommentsModel.fromJson(Map<String, dynamic> json) {
    return CampaignCommentsModel(
      id: json['id'],
      name: json['name'],
      comment: json['comment'],
      date: json['date'],
      isAnonymous: json['is_anonymous'],
    );
  }
}

class CampaignModel {
  final String id;
  final String campaignName;
  final String slugName;
  final int amountRequire;
  final int totalDonate;
  final String description;
  final String startDate;
  final String endDate;
  final Map<String, dynamic> category;
  final Map<String, dynamic> organizer;
  final List<ImagesModel> images;
  final List<CampaignCommentsModel> campaignComments;

  CampaignModel({
    required this.id,
    required this.campaignName,
    required this.slugName,
    required this.amountRequire,
    required this.totalDonate,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.category,
    required this.organizer,
    required this.images,
    required this.campaignComments,
  });

  factory CampaignModel.fromJson(Map<String, dynamic> json) {
    return CampaignModel(
      id: json['id'],
      campaignName: json['campaign_name'],
      slugName: json['slug_name'],
      amountRequire: json['amount_require'],
      totalDonate: json['total_donate'],
      description: json['description'],
      startDate: json['start_date'],
      endDate: json['end_date'],
      category: json['category'],
      organizer: json['organizer'],
      images: (json['images'] as List<dynamic>)
          .map((image) => ImagesModel.fromJson(image))
          .toList(),
      campaignComments: (json['campaign_comments'] as List<dynamic>)
          .map((comment) => CampaignCommentsModel.fromJson(comment))
          .toList(),
    );
  }
}
