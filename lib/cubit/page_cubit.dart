import 'package:bloc/bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PageCubit extends Cubit<int> {
  PageCubit() : super(0);

  void setPage(int page) async {
    emit(page);
  }
}
