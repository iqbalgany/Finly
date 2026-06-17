import 'package:finly/domain/entities/category/category_entity.dart';
import 'package:finly/domain/repositories/category/category_repository.dart';

class UpdateCategoryUseCases {
  final CategoryRepository repository;

  UpdateCategoryUseCases({required this.repository});

  Future<void> call(CategoryEntity category) async {
    if (category.id == null) {
      throw Exception('A category ID is required to perform an update');
    }

    return await repository.updateCategory(category);
  }
}
