part of 'transaction_cubit.dart';

class TransactionState extends Equatable {
  const TransactionState();

  @override
  List<Object?> get props => [];
}

final class TransactionInitial extends TransactionState {}

final class TransactionLoading extends TransactionState {}

final class TransactionSuccess extends TransactionState {
  final List<TransactionEntity>? transactions;

  const TransactionSuccess({this.transactions = const []});

  @override
  List<Object?> get props => [transactions];
}

final class TransactionError extends TransactionState {
  final String errorMessage;

  const TransactionError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
