part of 'users_cubit.dart';

sealed class UsersState extends Equatable {
  const UsersState();

  @override
  List<Object> get props => [];
}

final class UsersInitial extends UsersState {}

final class UsersLoading extends UsersState {}

final class UsersRegisterSuccess extends UsersState {}

final class UsersLoginSuccess extends UsersState {}

final class UsersFailed extends UsersState {
  String error;

  UsersFailed(this.error);

  @override
  List<Object> get props => [error];
}
