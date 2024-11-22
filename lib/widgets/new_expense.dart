import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/rendering.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;
  final TextStyle labelStyle = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    // color: Color(0xFF49454F),
  );

  void _presentDatePicker() async {
    final now = DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(now.year - 1, now.month - 1, now.day),
      lastDate: now,
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitExpenseForm() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid input'),
          content: const Text('Please make sure all input fields are valid.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Okay'),
            ),
          ],
        ),
      );
      return;
    }
    widget.onAddExpense(
      Expense(
        title: _titleController.text,
        amount: enteredAmount,
        date: _selectedDate!,
        category: _selectedCategory,
      ),
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Widget expenseField = TextField(
      controller: _titleController,
      maxLength: 50,
      decoration: const InputDecoration(
        label: Text('Expense Name'),
      ),
      style: labelStyle,
    );

    final Widget amountField = Expanded(
      child: TextField(
        controller: _amountController,
        decoration: const InputDecoration(
          prefixText: '\$',
          label: Text('Spent amount'),
        ),
        style: labelStyle,
        keyboardType: const TextInputType.numberWithOptions(
          decimal: true,
        ),
      ),
    );

    final Widget selectDate = Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            _selectedDate == null
                ? 'Selected Date'
                : formatter.format(_selectedDate!),
            style: labelStyle,
          ),
          IconButton(
            onPressed: _presentDatePicker,
            icon: const Icon(
              Icons.calendar_month,
            ),
          ),
        ],
      ),
    );

    final Widget categoryButton = DropdownButton(
      value: _selectedCategory,
      items: Category.values
          .map(
            (category) => DropdownMenuItem(
              value: category,
              child: Text(
                category.name.toUpperCase(),
                style: labelStyle,
              ),
            ),
          )
          .toList(),
      onChanged: (value) {
        if (value == null) return;
        setState(() {
          _selectedCategory = value;
        });
      },
    );

    final Widget categoryLabel = Text(
      'Category: ',
      style: labelStyle,
    );

    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(builder: (ctx, constraints) {
      final width = constraints.maxWidth;

      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 50, 16, keyboardSpace + 16),
            child: Column(
              children: [
                if (width >= 600)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: expenseField,
                      ),
                      const SizedBox(width: 24),
                      amountField,
                    ],
                  )
                else
                  expenseField,
                if (width >= 600)
                  Row(
                    children: [
                      categoryLabel,
                      const SizedBox(
                        width: 16,
                      ),
                      categoryButton,
                      const SizedBox(
                        width: 24,
                      ),
                      selectDate,
                    ],
                  )
                else
                  Column(
                    children: [
                      Row(
                        children: [
                          amountField,
                          // const SizedBox(width: 16,),
                          selectDate,
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          categoryLabel,
                          const SizedBox(
                            width: 16,
                          ),
                          categoryButton,
                        ],
                      ),
                    ],
                  ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel'),
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: _submitExpenseForm,
                      child: const Text('Save Expense'),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
