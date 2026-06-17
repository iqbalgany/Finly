import 'package:drift/drift.dart';
import 'package:finly/data/datasources/local/app_database.dart';
import 'package:finly/domain/entities/category/category_entity.dart';
import 'package:finly/domain/repositories/category/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final AppDatabase database;

  CategoryRepositoryImpl({required this.database});
  @override
  Future<void> deleteCategory(int id) async {
    await (database.update(database.categories)
          ..where((tbl) => tbl.id.equals(id)))
        .write(CategoriesCompanion(deletedAt: Value(DateTime.now())));
  }

  @override
  Future<List<CategoryEntity>> getCategories() async {
    final result = await (database.select(
      database.categories,
    )..where((tbl) => tbl.deletedAt.isNull())).get();

    return result
        .map(
          (row) => CategoryEntity(name: row.name, type: row.type, id: row.id),
        )
        .toList();
  }

  @override
  Future<void> insertCategory(CategoryEntity category) async {
    await database
        .into(database.categories)
        .insert(
          CategoriesCompanion.insert(
            name: category.name ?? '',
            type: category.type ?? 0,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          ),
        );
  }

  @override
  Future<void> updateCategory(CategoryEntity category) async {
    await database
        .update(database.categories)
        .replace(
          Category(
            id: category.id!,
            name: category.name ?? '',
            type: category.type ?? 0,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          ),
        );
  }
}
