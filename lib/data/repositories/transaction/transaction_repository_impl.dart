import 'package:drift/drift.dart';
import 'package:finly/data/datasources/local/app_database.dart';
import 'package:finly/domain/entities/transaction/transaction_entity.dart';
import 'package:finly/domain/repositories/transaction/transaction_repository.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  final AppDatabase database;

  TransactionRepositoryImpl({required this.database});

  @override
  Future<void> deleteTransaction(int id) async {
    await (database.update(database.transactions)
          ..where((tbl) => tbl.id.equals(id)))
        .write(TransactionsCompanion(deletedAt: Value(DateTime.now())));
  }

  @override
  Future<List<TransactionEntity>> getTransactions() async {
    final result = (database.select(database.transactions))..where(filter)
  }

  @override
  Future<void> insertTransaction(TransactionEntity transaction) {
    // TODO: implement insertTransaction
    throw UnimplementedError();
  }

  @override
  Future<void> updateTransaction(TransactionEntity transaction) {
    // TODO: implement updateTransaction
    throw UnimplementedError();
  }
}
