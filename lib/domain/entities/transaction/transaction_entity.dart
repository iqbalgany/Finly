import 'package:equatable/equatable.dart';

class TransactionEntity extends Equatable {
  final int? id;
  final String name;
  final int categoryId;
  final int amount;
  final DateTime transactionDate;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  const TransactionEntity({
    this.id,
    required this.name,
    required this.categoryId,
    required this.amount,
    required this.transactionDate,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    categoryId,
    amount,
    transactionDate,
    createdAt,
    deletedAt,
    updatedAt,
  ];
}
