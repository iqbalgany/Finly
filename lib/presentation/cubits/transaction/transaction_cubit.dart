import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:finly/domain/entities/category/category_entity.dart';
import 'package:finly/domain/usecases/transaction/delete_transaction.dart';
import 'package:finly/domain/usecases/transaction/get_transactions.dart';
import 'package:finly/domain/usecases/transaction/insert_transaction.dart';
import 'package:finly/domain/usecases/transaction/update_transaction.dart';

import '../../../domain/entities/transaction/transaction_entity.dart';

part 'transaction_state.dart';

class TransactionCubit extends Cubit<TransactionState> {
  final GetTransactionsUseCase getTransactionsUseCase;
  final InsertTransactionUseCase insertTransactionUseCase;
  final UpdateTransactionUseCase updateTransactionUseCase;
  final DeleteTransactionUseCase deleteTransactionUseCase;
  TransactionCubit({
    required this.getTransactionsUseCase,
    required this.insertTransactionUseCase,
    required this.updateTransactionUseCase,
    required this.deleteTransactionUseCase,
  }) : super(TransactionInitial());

  Future<void> addTransaction({
    required CategoryEntity category,
    required int amount,
    required DateTime transactionDate,
  }) async {
    emit(TransactionLoading());
    try {
      final newTransaction = TransactionEntity(
        category: category,
        amount: amount,
        transactionDate: transactionDate,
      );
      await insertTransactionUseCase(newTransaction);
      await getTransactions();
    } catch (e) {
      emit(TransactionError(errorMessage: e.toString()));
    }
  }

  Future<void> getTransactions() async {
    emit(TransactionLoading());
    try {
      final transactions = await getTransactionsUseCase();
      emit(TransactionSuccess(transactions: transactions));
    } catch (e) {
      emit(TransactionError(errorMessage: e.toString()));
    }
  }

  Future<void> deleteTransaction(int id) async {
    emit(TransactionLoading());
    try {
      await deleteTransactionUseCase(id);
      await getTransactions();
    } catch (e) {
      emit(TransactionError(errorMessage: e.toString()));
    }
  }

  Future<void> updateTransaction(TransactionEntity transaction) async {
    emit(TransactionLoading());
    try {
      await updateTransactionUseCase(transaction);
      await getTransactions();
    } catch (e) {
      emit(TransactionError(errorMessage: e.toString()));
    }
  }
}
