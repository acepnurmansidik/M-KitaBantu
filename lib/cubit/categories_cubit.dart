import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kitabantu/services/categories_service.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit() : super(CategoriesInitial());

  void fetchCategories() async {
    try {
      emit(CategoriesLoading());
      final result = await CategoriesService().getCategories();

      emit(CategoriesSuccess(result));
    } catch (e) {
      emit(CategoriesFailed(e.toString()));
    }
  }
}
