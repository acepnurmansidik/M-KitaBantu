import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kitabantu/models/users_model.dart';
import 'package:kitabantu/services/user_service.dart';

part 'users_state.dart';

class UsersCubit extends Cubit<UsersState> {
  UsersCubit() : super(UsersInitial());

  void signUp(RegisterModel body) async {
    try {
      emit(UsersLoading());
      await UsersService().authRegister(body);
      emit(UsersRegisterSuccess());
    } catch (e) {
      emit(UsersFailed(e.toString()));
    }
  }

  void signIn(LoginModel body) async {
    try {
      emit(UsersLoading());
      await UsersService().authLogin(body);
      emit(UsersLoginSuccess());
    } catch (e) {
      emit(UsersFailed(e.toString()));
    }
  }
}
