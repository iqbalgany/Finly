import 'package:finly/domain/repositories/transaction/transaction_repository.dart';

class DeleteTransactionUseCase {
  final TransactionRepository repository;

  DeleteTransactionUseCase({required this.repository});

  Future<void> call(int id) async {
    return await repository.deleteTransaction(id);
  }
}
