import 'package:finly/presentation/pages/transaction_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/utils/extensions.dart';
import '../../domain/entities/transaction/transaction_entity.dart';
import '../../domain/enums/category_type.dart';
import '../cubits/transaction/transaction_cubit.dart';

class TransactionItemCard extends StatelessWidget {
  final TransactionEntity transaction;
  const TransactionItemCard({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.black12),
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 10,
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        tileColor: Colors.white,
        title: Text(transaction.amount.toRupiah()),
        subtitle: Text(transaction.category.name!),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () {
                context.read<TransactionCubit>().deleteTransaction(
                  transaction.id!,
                );
              },
              icon: Icon(Icons.delete),
            ),
            SizedBox(width: 10),

            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        TransactionPage(transaction: transaction),
                  ),
                );
              },
              icon: Icon(Icons.edit),
            ),
          ],
        ),
        leading: Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            transaction.category.type == CategoryType.income
                ? Icons.download
                : Icons.upload,
            color: transaction.category.type == CategoryType.income
                ? Colors.green
                : Colors.red,
          ),
        ),
      ),
    );
  }
}
