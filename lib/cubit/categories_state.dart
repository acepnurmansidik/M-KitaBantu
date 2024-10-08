part of 'categories_cubit.dart';

sealed class CategoriesState extends Equatable {
  const CategoriesState();

  @override
  List<Object> get props => [];
}

final class CategoriesInitial extends CategoriesState {}

final class CategoriesLoading extends CategoriesState {}

final class CategoriesSuccess extends CategoriesState {
  final List<dynamic> categories;

  const CategoriesSuccess(this.categories);

  @override
  List<Object> get props => [categories];
}

final class CategoriesFailed extends CategoriesState {
  final String error;
  const CategoriesFailed(this.error);

  @override
  List<Object> get props => [error];
}
