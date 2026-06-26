import 'dart:developer';

import 'package:calendar_appbar/calendar_appbar.dart';
import 'package:finly/domain/entities/transaction/transaction_entity.dart';
import 'package:finly/domain/enums/category_type.dart';
import 'package:finly/presentation/cubits/transaction/transaction_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../widgets/financial_status_card.dart';
import '../widgets/transaction_item_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime _selectDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    context.read<TransactionCubit>().getTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TransactionCubit, TransactionState>(
      listener: (context, state) {},
      builder: (context, state) {
        int totalIncome = 0;
        int totalOutcome = 0;
        List<TransactionEntity> filteredTransactions = [];

        if (state is TransactionSuccess) {
          filteredTransactions = state.transactions!.where((tx) {
            final txDate = tx.transactionDate;

            return txDate.year == _selectDate.year &&
                txDate.month == _selectDate.month &&
                txDate.day == _selectDate.day;
          }).toList();

          totalIncome = state.transactions!
              .where((tx) => tx.category.type == CategoryType.income)
              .fold(0, (sum, tx) => sum + (tx.amount));

          totalOutcome = state.transactions!
              .where((tx) => tx.category.type == CategoryType.outcome)
              .fold(0, (sum, tx) => sum + (tx.amount));
        }
        return Scaffold(
          appBar: CalendarAppBar(
            onDateChanged: (value) {
              log(value.toString());
              setState(() {
                _selectDate = value;
              });
            },
            firstDate: DateTime.now().subtract(Duration(days: 140)),
            lastDate: DateTime.now(),
            backButton: false,
            locale: 'id',
            accent: Colors.orange,
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      FinancialStatusCard(
                        title: 'Income',
                        amount: totalIncome,
                        color: Colors.green,
                        icon: Icons.download,
                      ),

                      FinancialStatusCard(
                        title: 'Outcome',
                        amount: totalOutcome,
                        color: Colors.red,
                        icon: Icons.upload,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),

                Text(
                  'Transactions',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),

                if (state is TransactionLoading) ...[
                  Expanded(
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: ListView.builder(
                        itemCount: 3,
                        itemBuilder: (_, _) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.black12),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            elevation: 10,
                            child: ListTile(
                              onTap: () {},
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              tileColor: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ] else if (state is TransactionSuccess) ...[
                  if (filteredTransactions.isNotEmpty)
                    Expanded(
                      child: ListView.builder(
                        itemCount: filteredTransactions.length,
                        itemBuilder: (context, index) {
                          final transaction = filteredTransactions[index];
                          return TransactionItemCard(transaction: transaction);
                        },
                      ),
                    )
                  else
                    Expanded(
                      child: Center(child: Text('Transactions is Empty')),
                    ),
                ] else if (state is TransactionError) ...[
                  Expanded(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          'Terjadi Error: ${state.errorMessage}',
                          style: const TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ] else ...[
                  Expanded(
                    child: Center(child: Text('State tidak dikenal: $state')),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
