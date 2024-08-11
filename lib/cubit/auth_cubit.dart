import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kitabantu/models/auth_model.dart';
import 'package:kitabantu/services/auth_service.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  bool isLogin = true;

  void logOut() async {
    try {
      emit(AuthLoading());
      await AuthService().deleteToken();
      emit(AuthInitial());
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

  void checkToken() async {
    try {
      emit(AuthLoading());
      AuthDataModel data = await AuthService().getToken();
      if (data.token == "") {
        isLogin = false;
      } else {
        isLogin = true;
      }
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }
}
