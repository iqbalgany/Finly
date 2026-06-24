// ignore_for_file: public_member_api_docs, sort_constructors_first
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

  TransactionEntity copyWith({
    int? id,
    CategoryEntity? category,
    int? amount,
    DateTime? transactionDate,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
  }) {
    return TransactionEntity(
      id: id ?? this.id,
      category: category ?? this.category,
      amount: amount ?? this.amount,
      transactionDate: transactionDate ?? this.transactionDate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }
}
