import 'package:flutter/material.dart';

import '../../model/expense.dart';
import 'expense_item.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({super.key,
    required this.expenses,
    required this.onRemoveExpense,
  });

  final List<Expense> expenses;
  final void Function(Expense expense)  onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (context, index ){
      return Dismissible(key: ValueKey(expenses[index]),
          background: Container(
            color: Colors.red,
            child:const  Icon(Icons.delete),
          ),
          onDismissed: (direction){
           onRemoveExpense(expenses[index]);
          },
          child: ExpanseItem(expenses[index]));
    },
    itemCount: expenses.length,
    );
  }
}
