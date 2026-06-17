import 'package:finly/domain/repositories/category/category_repository.dart';

class DeleteCategoryUseCases {
  final CategoryRepository repository;

  DeleteCategoryUseCases({required this.repository});

  Future<void> call(int id) async {
    return await repository.deleteCategory(id);
  }
}
