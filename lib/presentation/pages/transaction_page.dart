import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:finly/domain/entities/category/category_entity.dart';
import 'package:finly/domain/enums/category_type.dart';
import 'package:finly/presentation/cubits/category/category_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../cubits/transaction/transaction_cubit.dart';
import '../widgets/custom_text_field.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  bool _isSwitchOn = true;

  final _amount = TextEditingController();
  final _category = TextEditingController();
  final _date = TextEditingController();

  CategoryEntity? _selectedCategory;
  DateTime? _rawSelectedDate;

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      _rawSelectedDate = pickedDate;
      String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);

      setState(() {
        _date.text = formattedDate;
      });
    }
  }

  final CurrencyTextInputFormatter _amountFormatter =
      CurrencyTextInputFormatter.currency(
        locale: 'id',
        symbol: 'Rp ',
        decimalDigits: 0,
      );

  @override
  void initState() {
    super.initState();
    context.read<CategoryCubit>().getCategories();
  }

  @override
  void dispose() {
    _amount.dispose();
    _category.dispose();
    _date.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Transaction', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.orange,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                Switch(
                  activeThumbColor: Colors.white,
                  inactiveThumbColor: Colors.white,
                  activeTrackColor: Colors.green,
                  inactiveTrackColor: Colors.red,
                  trackOutlineColor: WidgetStatePropertyAll(Colors.transparent),
                  value: _isSwitchOn,
                  onChanged: (value) {
                    setState(() {
                      _isSwitchOn = value;
                      _selectedCategory = null;
                      _category.clear();
                    });
                  },
                ),
                SizedBox(width: 10),

                Text(_isSwitchOn == true ? 'Income' : 'Outcome'),
              ],
            ),
            SizedBox(height: 30),

            CustomTextField(
              labelText: 'Amount',
              keyboardType: TextInputType.number,
              controller: _amount,
            ),
            SizedBox(height: 20),

            BlocBuilder<CategoryCubit, CategoryState>(
              builder: (context, state) {
                List<CategoryEntity> filteredItems = [];

                if (state is CategorySuccess) {
                  final targetType = _isSwitchOn
                      ? CategoryType.income
                      : CategoryType.outcome;

                  filteredItems =
                      state.categories
                          ?.where((cat) => cat.type == targetType)
                          .toList() ??
                      [];
                }
                return DropdownMenu<CategoryEntity>(
                  controller: _category,
                  hintText: 'Category',
                  requestFocusOnTap: false,
                  enableSearch: false,
                  width: MediaQuery.sizeOf(context).width - 40,
                  inputDecorationTheme: InputDecorationTheme(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.orange, width: 2),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.orange, width: 2),
                    ),
                  ),
                  onSelected: (CategoryEntity? value) {
                    setState(() {
                      _selectedCategory = value;
                    });
                  },
                  dropdownMenuEntries: filteredItems
                      .map<DropdownMenuEntry<CategoryEntity>>((
                        CategoryEntity cat,
                      ) {
                        return DropdownMenuEntry<CategoryEntity>(
                          value: cat,
                          label: cat.name!,
                        );
                      })
                      .toList(),
                );
              },
            ),
            SizedBox(height: 20),

            CustomTextField(
              readOnly: true,
              labelText: 'Enter Date',
              keyboardType: TextInputType.datetime,
              controller: _date,
              onTap: () {
                _selectDate(context);
              },
            ),
            SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                if (_amount.text.isNotEmpty &&
                    _rawSelectedDate != null &&
                    _selectedCategory != null) {
                  context.read<TransactionCubit>().addTransaction(
                    category: _selectedCategory!,
                    amount: int.parse(_amount.text.trim()),
                    transactionDate: _rawSelectedDate!,
                  );

                  _amount.clear();
                  _category.clear();
                  _date.clear();

                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('All fields must be filled out!'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                elevation: 10,
                fixedSize: Size(MediaQuery.sizeOf(context).width, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Save',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
