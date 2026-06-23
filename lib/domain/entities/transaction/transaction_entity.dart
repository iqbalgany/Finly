import 'package:equatable/equatable.dart';
import 'package:finly/domain/entities/category/category_entity.dart';

class TransactionEntity extends Equatable {
  final int? id;
  final CategoryEntity category;
  final int amount;
  final DateTime transactionDate;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;

  const TransactionEntity({
    this.id,
    required this.category,
    required this.amount,
    required this.transactionDate,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  @override
  List<Object?> get props => [
    id,
    category,
    amount,
    transactionDate,
    createdAt,
    deletedAt,
    updatedAt,
  ];
}
