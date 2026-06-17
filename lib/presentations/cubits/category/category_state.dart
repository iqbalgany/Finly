part of 'category_cubit.dart';

class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object?> get props => [];
}

final class CategoryInitial extends CategoryState {}

final class CategoryLoading extends CategoryState {}

final class CategorySuccess extends CategoryState {
  final List<CategoryEntity>? categories;

  const CategorySuccess({this.categories = const []});

  @override
  List<Object?> get props => [categories];
}

final class CategoryError extends CategoryState {
  final String errorMessage;

  const CategoryError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
