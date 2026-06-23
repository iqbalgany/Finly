import 'package:drift/drift.dart';
import 'package:finly/data/datasources/local/app_database.dart';
import 'package:finly/data/models/transaction/transaction_model.dart';
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
    final query = database.select(database.transactions).join([
      innerJoin(
        database.categories,
        database.categories.id.equalsExp(database.transactions.categoryId),
      ),
    ])..where(database.transactions.deletedAt.isNull());

    final result = await query.get();

    return result.map((row) {
      final transactionData = row.readTable(database.transactions);
      final categoryData = row.readTable(database.categories);

      return TransactionModel.fromDrift(transactionData, categoryData);
    }).toList();
  }

  @override
  Future<void> insertTransaction(TransactionEntity transaction) async {
    await database
        .into(database.transactions)
        .insert(
          TransactionsCompanion.insert(
            categoryId: transaction.category.id!,
            amount: transaction.amount,
            transactionDate: transaction.transactionDate,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          ),
        );
  }

  @override
  Future<void> updateTransaction(TransactionEntity transaction) async {
    await (database.update(
      database.transactions,
    )..where((tbl) => tbl.id.equals(transaction.id!))).write(
      TransactionsCompanion(
        categoryId: Value(transaction.category.id!),
        amount: Value(transaction.amount),
        transactionDate: Value(transaction.transactionDate),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }
}
