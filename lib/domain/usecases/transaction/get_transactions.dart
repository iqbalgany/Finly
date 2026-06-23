import 'package:finly/domain/entities/transaction/transaction_entity.dart';
import 'package:finly/domain/repositories/transaction/transaction_repository.dart';

class GetTransactionsUseCase {
  final TransactionRepository repository;

  GetTransactionsUseCase({required this.repository});

  Future<List<TransactionEntity>> call() async {
    return await repository.getTransactions();
  }
}
