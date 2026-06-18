import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:finly/data/datasources/local/tables/category/category.dart';
import 'package:finly/data/datasources/local/tables/transaction/transaction.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [Categories, Transactions])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return LazyDatabase(() async {
      return driftDatabase(name: 'note_app');
    });
  }
}
