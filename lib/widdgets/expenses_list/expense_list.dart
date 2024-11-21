import 'package:flutter/material.dart';
import '../../models/expens.dart';
import 'expense_item.dart';

class ExpensesList extends StatelessWidget {
  ExpensesList({super.key, required this.expenses, required this.RemoveExpense});

  List<Expense> expenses;
  final void Function(Expense expense) RemoveExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(

      itemBuilder: (context, index) => Dismissible(
        onDismissed: (direction){
          RemoveExpense(expenses[index]);
        },
        key: ValueKey(expenses[index]),
        child: ExpensesItem(expenses[index]),
      ),
      itemCount: expenses.length,
    );
  }
}
