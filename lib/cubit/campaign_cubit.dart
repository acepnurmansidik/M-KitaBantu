import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kitabantu/models/campaign_model.dart';
import 'package:kitabantu/services/campaign_service.dart';
import 'package:kitabantu/services/categories_service.dart';

part 'campaign_state.dart';

class CampaignCubit extends Cubit<CampaignState> {
  CampaignCubit() : super(CampaignInitial());

  void fetchCampaigns() async {
    try {
      emit(CampaignILoading());
      final campaigns = await CampaignService().getCampaigns();
      final banner = await CampaignService().getCampaigns();
      final campaignFastHelp = await CampaignService().getCampaigns();
      final campaignsCarousel =
          await CampaignService().getCampaigns(limit: 4, fastHelp: true);

      final categories = await CategoriesService().getCategories();
      final filterCampaigns = await CampaignService()
          .getCampaigns(category: categories[0].slugName);

      emit(CampaignSuccess(
          campaigns: campaigns,
          campaignsCarousel: campaignsCarousel,
          filterCampaigns: filterCampaigns,
          banner: banner,
          campaignFastHelp: campaignFastHelp));
    } catch (e) {
      emit(CampaignFailed(e.toString()));
    }
  }

  void createUserDonateCampaign(DonateCampaignModel body) async {
    final state = this.state;
    try {
      emit(CampaignILoading());
      await CampaignService().postDonateCampaign(body);

      if (state is CampaignSuccess) {
        emit(CampaignSuccess(
          campaigns: state.campaigns,
          campaignsCarousel: state.campaignsCarousel,
          filterCampaigns: state.filterCampaigns,
          campaignFastHelp: state.campaignFastHelp,
          banner: state.banner,
        ));
      }
    } catch (e) {
      emit(CampaignFailed(e.toString()));
    }
  }

  void fetchFilterCampaigns(String setFilter) async {
    final state = this.state;
    try {
      final filterCampaigns =
          await CampaignService().getCampaigns(category: setFilter);

      if (state is CampaignSuccess) {
        emit(CampaignSuccess(
          campaigns: state.campaigns,
          campaignsCarousel: state.campaignsCarousel,
          campaignFastHelp: state.campaignFastHelp,
          filterCampaigns: filterCampaigns,
          banner: state.banner,
        ));
      }
    } catch (e) {
      emit(CampaignFailed(e.toString()));
    }
  }
}
