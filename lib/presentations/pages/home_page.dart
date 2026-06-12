import 'package:calendar_appbar/calendar_appbar.dart';
import 'package:flutter/material.dart';

import '../widgets/financial_status_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CalendarAppBar(
        onDateChanged: (value) => print(value),
        firstDate: DateTime.now().subtract(Duration(days: 140)),
        lastDate: DateTime.now(),
        backButton: false,
        locale: 'id',
        accent: Colors.orange,
      ),
      body: SingleChildScrollView(
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
                    amount: '3.800.000',
                    color: Colors.green,
                    icon: Icons.download,
                  ),

                  FinancialStatusCard(
                    title: 'Outcome',
                    amount: '1.600.000',
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

            Card(
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
                title: Text('Rp20.000'),
                subtitle: Text('Sallary'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
                    SizedBox(width: 10),

                    IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
                  ],
                ),
                leading: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(Icons.download, color: Colors.green),
                ),
              ),
            ),
            Card(
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
                title: Text('Rp20.000'),
                subtitle: Text('lunch'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
                    SizedBox(width: 10),

                    IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
                  ],
                ),
                leading: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(Icons.upload, color: Colors.red),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
