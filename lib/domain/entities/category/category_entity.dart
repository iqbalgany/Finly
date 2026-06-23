import '../../enums/category_type.dart';

class CategoryEntity {
  final int? id;
  final String? name;
  final CategoryType? type;

  CategoryEntity({this.id, required this.name, required this.type});
}
