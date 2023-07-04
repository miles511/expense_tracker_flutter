// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:expanse/model/expense.dart';



final formatter = DateFormat.yMd();

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {

final _titleController = TextEditingController();
final _amountController = TextEditingController();
DateTime? _selectedDate;
Category _selectedCategory = Category.leisure;

void _presentDatePicker() async{
  final now = DateTime.now();
  final firstDate = DateTime(now.year - 1, now.month, now.day);
 final pickedDate = await showDatePicker(context: context, initialDate: now,
      firstDate: firstDate,
      lastDate: now);

 setState(() {
   _selectedDate = pickedDate;
 });
}

void _submitExpenseData () {
  final enteredAmount = double.tryParse(_amountController.text);
  final amountisInvalid = enteredAmount == null || enteredAmount <= 0;
   if (_titleController.text.trim().isEmpty || amountisInvalid || _selectedDate == null ) {
       showDialog(context: context, builder: (ctx) =>  AlertDialog(
         title: const Text('Invalid Input'),
             content:  const Text('please make sure a valid title, amount, date and category was entered '),
         actions: [
           TextButton(onPressed: (){
             Navigator.pop(ctx);
           }, child: const Text('Okay'),),
         ],
       ));
       return;
   }
   widget.onAddExpense(Expense(
       title: _titleController.text,
       amount: enteredAmount,
       date: _selectedDate!,
       category: _selectedCategory),
   );
   Navigator.pop(context);
}

  @override

  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
       child: Column(
         children:  [
           TextField(
             controller: _titleController,
             maxLength: 50,
             decoration: const InputDecoration(

               label: Text('Title'),
             ),
           ),
           Row(
             children: [
               Expanded(
                 child: TextField(
                     keyboardType: TextInputType.number,
                     controller: _amountController,
                     maxLength: 15,
                     decoration: const InputDecoration(
                       prefixText: '\$ ',
                       label: Text('Amount'),
                     )
                 ),
               ),
               const SizedBox(width: 16.0),
               Expanded(
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.end,
                   children: [
                      Text(_selectedDate == null ? 'No date selected' :   formatter.format(_selectedDate! ) ),
                     IconButton(onPressed: (){
                         _presentDatePicker();
                     }, icon: const Icon(Icons.calendar_month))
                   ],
                 ),
               ),
             ]
           ),
           Row(
             children: [
               DropdownButton(
                   value: _selectedCategory,
                   items: Category.values.map((category) => DropdownMenuItem(
                 value: category,
                   child: Text(category.name.toUpperCase(),),),).toList(),
                   onChanged: (value){
                 setState(() {
                   if (value == null) {
                     return;
                   }
                   _selectedCategory = value;
                 });
                      print(value);
                   }),
               const Spacer(),
               
               TextButton(onPressed: (){
                 Navigator.pop(context);

               }, child: const Text('Cancel')),

               ElevatedButton(onPressed: _submitExpenseData,
                 child: const Text('Save Expense'),),

             ]
           ),
         ]
       )
    );
  }
}
