import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expense, {super.key});
  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 30,
          horizontal: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              expense.title,
              style: Theme.of(context).textTheme.titleMedium,
              // style: TextStyle(
              //   color: Theme.of(context).textTheme.titleMedium,
              //   fontWeight: FontWeight.bold,
              // ),
            ),
            const SizedBox(height: 4,),
            Row(
              children: [
                Text('\$${expense.amount.toStringAsFixed(2)}'),
                const Spacer(),
                Row(children: [
                  Icon(categoryIcons[expense.category]),
                  const SizedBox(width: 8),
                  Text(expense.formattedDate),
                ],),
              ],
            ),
          ],
        ),
      ),
    );
  }
}