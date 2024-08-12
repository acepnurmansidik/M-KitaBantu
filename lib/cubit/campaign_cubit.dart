import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
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
}
