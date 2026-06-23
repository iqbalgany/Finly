import 'package:finly/core/utils/extensions.dart';
import 'package:flutter/material.dart';

class FinancialStatusCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final int amount;
  const FinancialStatusCard({
    super.key,
    required this.icon,
    required this.color,
    required this.title,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color),
        ),
        SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(color: Colors.white, fontSize: 12)),
            SizedBox(height: 5),
            Text(amount.toRupiah(), style: TextStyle(color: Colors.white)),
          ],
        ),
      ],
    );
  }
}
