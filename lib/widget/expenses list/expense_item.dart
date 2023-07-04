import 'package:flutter/material.dart';
import 'package:expanse/model/expense.dart';

class ExpanseItem extends StatelessWidget {
  const ExpanseItem( this.expense, {super.key});
  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(expense.title,
            style: const TextStyle(
              fontWeight: FontWeight.w800,
            )
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Text('\$${expense.amount.toStringAsFixed(2)}'),
                const Spacer(),
                Row(
                  children: [
                    Icon(categoryIcons[expense.category]),
                    Text(expense.formattedDate)
                  ]
                ),
              ]
            ),
          ]
        )
      ),
    );
  }
}
