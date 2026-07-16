import 'package:flutter/material.dart';
import 'package:rev_expense_app/models/expense.dart';
import 'package:rev_expense_app/widget/expenses_list/expenses_item.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    super.key,
    required this.expenses,
    required this.onRemoveExpense,
  });

  final List<Expense> expenses;
  final void Function(Expense expense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, index) {

        return Dismissible(
          key: ValueKey(expenses[index]),
          background: Container(
            color: Theme.of(context).colorScheme.error,
            margin: EdgeInsets.symmetric(
              horizontal:
              (Theme.of(context).cardTheme.margin as EdgeInsets?)?.left ?? 16,

              vertical: 8,
            ),
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20),
            child: const Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
          onDismissed: (direction) {
            onRemoveExpense(expenses[index]);
          },
          child: ExpensesItem(expenses[index]),
        );
      },
    );
  }
}