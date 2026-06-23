import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:finly/domain/entities/category/category_entity.dart';
import 'package:finly/domain/enums/category_type.dart';
import 'package:finly/domain/usecases/category/delete_category.dart';
import 'package:finly/domain/usecases/category/get_categories.dart';
import 'package:finly/domain/usecases/category/insert_category.dart';
import 'package:finly/domain/usecases/category/update_category.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final GetCategoriesUseCases getCategoriesUseCases;
  final InsertCategoryUseCases insertCategoryUseCases;
  final DeleteCategoryUseCases deleteCategoryUseCases;
  final UpdateCategoryUseCases updateCategoryUseCases;
  CategoryCubit({
    required this.getCategoriesUseCases,
    required this.insertCategoryUseCases,
    required this.deleteCategoryUseCases,
    required this.updateCategoryUseCases,
  }) : super(CategoryInitial());

  Future<void> addCategory(String name, CategoryType type) async {
    emit(CategoryLoading());
    try {
      final newCategory = CategoryEntity(name: name, type: type);
      await insertCategoryUseCases(newCategory);
      await getCategories();
    } catch (e) {
      emit(CategoryError(errorMessage: e.toString()));
    }
  }

  Future<void> getCategories() async {
    emit(CategoryLoading());
    try {
      final categories = await getCategoriesUseCases();
      emit(CategorySuccess(categories: categories));
    } catch (e) {
      emit(CategoryError(errorMessage: e.toString()));
    }
  }

  Future<void> deleteCategory(int id) async {
    emit(CategoryLoading());
    try {
      await deleteCategoryUseCases(id);
      await getCategories();
    } catch (e) {
      emit(CategoryError(errorMessage: e.toString()));
    }
  }

  Future<void> updateCategory(CategoryEntity category) async {
    emit(CategoryLoading());
    try {
      await updateCategoryUseCases(category);
      await getCategories();
    } catch (e) {
      emit(CategoryError(errorMessage: e.toString()));
    }
  }
}
