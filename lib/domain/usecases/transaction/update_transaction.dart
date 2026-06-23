import 'package:finly/domain/entities/transaction/transaction_entity.dart';
import 'package:finly/domain/repositories/transaction/transaction_repository.dart';

class UpdateTransactionUseCase {
  final TransactionRepository repository;

  UpdateTransactionUseCase({required this.repository});

  Future<void> call(TransactionEntity transaction) async {
    if (transaction.id == null) {
      throw Exception('A Transaction ID is required to perform an update');
    }

    return await repository.updateTransaction(transaction);
  }
}
