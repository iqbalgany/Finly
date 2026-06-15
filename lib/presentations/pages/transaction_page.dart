import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

  List<String> items = ['Makan dan Jajan', 'Transportasi', 'Nonton Film'];

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);

      setState(() {
        _date.text = formattedDate;
      });
    }
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

            DropdownMenu<String>(
              controller: _category,
              hintText: 'Category',
              requestFocusOnTap: true,
              enableSearch: true,
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
              searchCallback:
                  (List<DropdownMenuEntry<String>> entries, String query) {
                    if (query.isEmpty) return null;

                    final int index = entries.indexWhere(
                      (entry) => entry.label.toLowerCase().contains(
                        query.toLowerCase(),
                      ),
                    );

                    return index != -1 ? index : null;
                  },
              onSelected: (value) {},
              dropdownMenuEntries: items.map<DropdownMenuEntry<String>>((
                String value,
              ) {
                return DropdownMenuEntry<String>(value: value, label: value);
              }).toList(),
            ),
            SizedBox(height: 20),

            CustomTextField(
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
                _amount.clear();
                _category.clear();
                _date.clear();
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
