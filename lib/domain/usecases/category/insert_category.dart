import 'package:finly/domain/entities/category/category_entity.dart';
import 'package:finly/domain/repositories/category/category_repository.dart';

class InsertCategoryUseCases {
  final CategoryRepository repository;

  InsertCategoryUseCases({required this.repository});

  Future<void> call(CategoryEntity category) async {
    if (category.name!.isEmpty) {
      throw Exception('Category name cannot be emptyClick to apply');
    }
    return await repository.insertCategory(category);
  }
}
