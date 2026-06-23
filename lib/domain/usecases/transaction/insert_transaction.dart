import 'package:finly/domain/entities/transaction/transaction_entity.dart';
import 'package:finly/domain/repositories/transaction/transaction_repository.dart';

class InsertTransactionUseCase {
  final TransactionRepository repository;

  InsertTransactionUseCase({required this.repository});

  Future<void> call(TransactionEntity transaction) async {
    return await repository.insertTransaction(transaction);
  }
}
