import 'package:finly/domain/entities/category/category_entity.dart';
import 'package:finly/domain/repositories/category/category_repository.dart';

class GetCategoriesUseCases {
  final CategoryRepository repository;

  GetCategoriesUseCases({required this.repository});

  Future<List<CategoryEntity>> call() async {
    return await repository.getCategories();
  }
}
