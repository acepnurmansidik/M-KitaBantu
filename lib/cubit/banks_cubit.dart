import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kitabantu/services/bank_service.dart';

part 'banks_state.dart';

class BanksCubit extends Cubit<BanksState> {
  BanksCubit() : super(BanksInitial());

  void fectBanks() async {
    try {
      emit(BanksLoading());
      final banks = await BankService().getBanks();

      emit(BanksSuccess(banks));
    } catch (e) {
      emit(BanksFailed(e.toString()));
    }
  }
}
