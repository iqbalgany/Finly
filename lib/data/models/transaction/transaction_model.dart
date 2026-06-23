import 'package:drift/drift.dart';
import 'package:finly/data/datasources/local/app_database.dart';
import 'package:finly/data/models/category/category_model.dart';
import 'package:finly/domain/entities/category/category_entity.dart';
import 'package:finly/domain/entities/transaction/transaction_entity.dart';
import 'package:finly/domain/enums/category_type.dart';

class TransactionModel extends TransactionEntity {
  const TransactionModel({
    super.id,
    required super.category,
    required super.amount,
    required super.transactionDate,
    required super.createdAt,
    required super.updatedAt,
    super.deletedAt,
  });

  factory TransactionModel.fromDrift(Transaction data, Category cat) {
    return TransactionModel(
      category: cat.toEntity(),
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
      categoryId: category.id!,
      amount: amount,
      transactionDate: transactionDate,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      id: id != null ? Value(id!) : const Value.absent(),
      deletedAt: deletedAt != null ? Value(deletedAt) : const Value.absent(),
    );
  }

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'] as int?,
      category: CategoryEntity(
        id: json['category_id'] as int,
        name: json['category_name'] as String? ?? '',
        type: json['category_type'] as int == 0
            ? CategoryType.income
            : CategoryType.outcome,
      ),
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
      'category_id': category.id,
      'amount': amount,
      'transaction_date': transactionDate.toIso8601String(),
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'deleted_at': deletedAt?.toIso8601String(),
    };
  }
}
