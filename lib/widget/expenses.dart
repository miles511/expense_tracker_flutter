import 'package:expanse/model/new_expense.dart';
import 'package:expanse/widget/chart/chart.dart';
import 'package:expanse/widget/expenses%20list/expense_list.dart';
import 'package:flutter/material.dart';
import '../model/expense.dart';


class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {


  final List<Expense> _registeredExpenses = [
    Expense(
        title: 'Flutter Course',
        amount: 20.54,
        date: DateTime.now(),
        category: Category.work),

    Expense(
        title: 'Cinema',
        amount: 10.54,
        date: DateTime.now(),
        category: Category.leisure),
  ];

  void _openAddExpenseOverlay() {
        showModalBottomSheet(
            isScrollControlled: true,
            context: context, builder: (ctx){
          return NewExpense(onAddExpense: _addExpense);
        });
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(seconds: 3),
        content: const  Text('Expense deleted'),
        action:  SnackBarAction(label: 'Undo',
            onPressed: (){
          setState(() {
            _registeredExpenses.insert(expenseIndex, expense);
          });
            })
    ));
  }

  @override
  Widget build(BuildContext context) {

    Widget mainContent =
    const Center(
        child:  Text('No expenses found. start adding some!'));

    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
          expenses: _registeredExpenses, onRemoveExpense: _removeExpense);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Expense Tracker'),
        actions: [
          IconButton(onPressed: (){
           _openAddExpenseOverlay();
          }, icon: const Icon(Icons.add),)
        ],
      ),
      body: Column(
        children: [
          // const Text('The Chart'),
          Chart(expenses: _registeredExpenses),
          Expanded(
              child: mainContent,
          )
        ],
      ),
    );
  }
}
