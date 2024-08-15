part of 'campaign_cubit.dart';

sealed class CampaignState extends Equatable {
  const CampaignState();

  @override
  List<Object> get props => [];
}

final class CampaignInitial extends CampaignState {}

final class CampaignILoading extends CampaignState {}

final class CampaignDonateCampaignSuccess extends CampaignState {}

final class CampaignSuccess extends CampaignState {
  final List<dynamic> campaigns;

  const CampaignSuccess(this.campaigns);

  @override
  List<Object> get props => [campaigns];
}

final class CampaignFailed extends CampaignState {
  final String error;

  const CampaignFailed(this.error);

  @override
  List<Object> get props => [error];
}
