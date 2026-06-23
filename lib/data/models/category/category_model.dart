import 'package:finly/data/datasources/local/app_database.dart';
import 'package:finly/domain/entities/category/category_entity.dart';
import 'package:finly/domain/enums/category_type.dart';

extension CategoryDataX on Category {
  CategoryEntity toEntity() {
    return CategoryEntity(name: name, type: CategoryType.fromInt(type), id: id);
  }
}

class CategoryModel {
  static CategoriesCompanion toDriftCompanion(CategoryEntity entity) {
    return CategoriesCompanion.insert(
      name: entity.name ?? '',
      type: entity.type!.value,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }
}
