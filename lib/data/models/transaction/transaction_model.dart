import 'package:drift/drift.dart';
import 'package:finly/data/datasources/local/app_database.dart';
import 'package:finly/domain/entities/transaction/transaction_entity.dart';

class TransactionModel extends TransactionEntity {
  const TransactionModel({
    super.id,
    required super.name,
    required super.categoryId,
    required super.amount,
    required super.transactionDate,
    required super.createdAt,
    required super.updatedAt,
    super.deletedAt,
  });

  factory TransactionModel.fromDrift(Transaction data) {
    return TransactionModel(
      name: data.name,
      categoryId: data.categoryId,
      amount: data.amount,
      transactionDate: data.transactionDate,
      createdAt: data.createdAt,
      updatedAt: data.updatedAt,
      deletedAt: data.deletedAt,
      id: data.id,
    );
  }

  TransactionsCompanion toDriftCompanion() {
    return TransactionsCompanion.insert(
      name: name,
      categoryId: categoryId,
      amount: amount,
      transactionDate: transactionDate,
      createdAt: createdAt,
      updatedAt: updatedAt,
      id: id != null ? Value(id!) : const Value.absent(),
      deletedAt: deletedAt != null ? Value(deletedAt) : const Value.absent(),
    );
  }

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      name: json['name'] as String,
      categoryId: json['category_id'] as int,
      amount: json['amount'] as int,
      transactionDate: DateTime.parse(json['transaction_date'] as String),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_date'] as String),
      deletedAt: json['deleted_at'] != null
          ? DateTime.parse(json['transaction_date'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category_id': categoryId,
      'amount': amount,
      'transaction_date': transactionDate.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'deleted_at': deletedAt?.toIso8601String(),
    };
  }
}
