import 'package:flutter/material.dart';

import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expenses_list/expense_item.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {super.key, required this.expenses, required this.onDismissExpense});
  final List<Expense> expenses;
  final void Function(Expense expense) onDismissExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, i) => Dismissible(
        key: ValueKey(expenses[i]),
        background: Container(
          color:
              Theme.of(context).colorScheme.secondaryContainer.withOpacity(0.5),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 20,
              ),
              Icon(Icons.delete),
            ],
          ),
        ),
        onDismissed: (direction) {
          onDismissExpense(expenses[i]);
        },
        child: ExpenseItem(expenses[i]),
      ),
    );
  }
}
