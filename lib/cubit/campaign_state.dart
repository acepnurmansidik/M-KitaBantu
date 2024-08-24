part of 'campaign_cubit.dart';

sealed class CampaignState extends Equatable {
  const CampaignState();

  @override
  List<Object> get props => [];
}

final class CampaignInitial extends CampaignState {}

final class CampaignILoading extends CampaignState {}

final class CampaignSuccess extends CampaignState {
  final List<dynamic> campaigns;
  final List<dynamic> campaignsCarousel;
  final List<dynamic> filterCampaigns;
  final List<dynamic> banner;
  final List<dynamic> campaignFastHelp;

  const CampaignSuccess({
    required this.campaigns,
    required this.campaignsCarousel,
    required this.filterCampaigns,
    required this.campaignFastHelp,
    required this.banner,
  });

  @override
  List<Object> get props =>
      [campaigns, campaignsCarousel, filterCampaigns, banner, campaignFastHelp];
}

final class CampaignFailed extends CampaignState {
  final String error;

  const CampaignFailed(this.error);

  @override
  List<Object> get props => [error];
}
