import 'package:finly/data/datasources/local/app_database.dart';
import 'package:finly/domain/entities/category/category_entity.dart';

extension CategoryDataX on Category {
  CategoryEntity toEntity() {
    return CategoryEntity(name: name, type: type, id: id);
  }
}

class CategoryModel {
  static CategoriesCompanion toDriftCompanion(CategoryEntity entity) {
    return CategoriesCompanion.insert(
      name: entity.name ?? '',
      type: entity.type ?? 0,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }
}
