import 'package:flutter/material.dart';
import '../../models/expens.dart';


class ExpensesItem extends StatelessWidget {
  ExpensesItem(this.expense, {super.key});

  Expense expense;

  @override
  Widget build(BuildContext context) {
    return Card( color: Colors.grey[100],
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          children: [
            Row(children: [
              Icon(CategoryIcons[expense.category]),
              SizedBox(
                width: 8,
              ),
              Text(expense.category.name),
              const Spacer(),
              Text(
                '-\$${expense.amount.toStringAsFixed(2)}',
                style: TextStyle(color: Colors.red[900]),
              ),
            ]),
            SizedBox(
              height: 4,
            ),
            Row(
              children: [
                SizedBox(
                  width: 30,
                ),
                Text(
                  expense.title,
                  style: TextStyle(color: Colors.grey),
                ),
                const Spacer(),
                Row(
                  children: [
                    SizedBox(
                      width: 5,
                    ),
                    Text(expense.getDate()),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
