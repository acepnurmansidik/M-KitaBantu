import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kitabantu/models/campaign_model.dart';
import 'package:kitabantu/services/campaign_service.dart';

part 'campaign_state.dart';

class CampaignCubit extends Cubit<CampaignState> {
  CampaignCubit() : super(CampaignInitial());

  void fetchCampaigns() async {
    try {
      emit(CampaignILoading());
      final campaigns = await CampaignService().getCampaigns();
      emit(CampaignSuccess(campaigns));
    } catch (e) {
      emit(CampaignFailed(e.toString()));
    }
  }

  void createUserDonateCampaign(DonateCampaignModel body) async {
    try {
      emit(CampaignILoading());
      await CampaignService().postDonateCampaign(body);
      emit(CampaignDonateCampaignSuccess());
    } catch (e) {
      emit(CampaignFailed(e.toString()));
    }
  }
}
