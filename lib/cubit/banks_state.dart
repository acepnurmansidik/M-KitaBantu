part of 'banks_cubit.dart';

sealed class BanksState extends Equatable {
  const BanksState();

  @override
  List<Object> get props => [];
}

final class BanksInitial extends BanksState {}

final class BanksLoading extends BanksState {}

final class BanksSuccess extends BanksState {
  final List<dynamic> banks;

  const BanksSuccess(this.banks);

  @override
  List<Object> get props => [banks];
}

final class BanksFailed extends BanksState {
  final String error;

  const BanksFailed(this.error);

  @override
  List<Object> get props => [error];
}
