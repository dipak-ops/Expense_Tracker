
import 'package:flutter/material.dart';
import 'package:rev_expense_app/models/expense.dart';
import 'package:rev_expense_app/widget/expenses_list/expenses_list.dart';
import 'package:rev_expense_app/widget/new_expense.dart';
import 'package:rev_expense_app/widget/chart/chart.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
  Expense(
    title: 'Burger',
    amount: 250,
    date: DateTime.now(),
    categroy: Category.food,
  ),
  Expense(
    title: 'Bus Ticket',
    amount: 120,
    date: DateTime.now(),
    categroy: Category.travel,
  ),
  Expense(
    title: 'Shopping',
    amount: 1800,
    date: DateTime.now(),
    categroy: Category.shopping,
  ),
  Expense(
    title: 'Movie',
    amount: 450,
    date: DateTime.now(),
    categroy: Category.entertainment,
  ),
  Expense(
    title: 'Medicine',
    amount: 650,
    date: DateTime.now(),
    categroy: Category.health,
  ),
  Expense(
    title: 'Flutter Course',
    amount: 1223,
    date: DateTime.now(),
    categroy: Category.education,
  ),
  Expense(
    title: 'Office Supplies',
    amount: 850,
    date: DateTime.now(),
    categroy: Category.work,
  ),
  Expense(
    title: 'Electricity Bill',
    amount: 1500,
    date: DateTime.now(),
    categroy: Category.bills,
  ),
  Expense(
    title: 'Groceries',
    amount: 950,
    date: DateTime.now(),
    categroy: Category.groceries,
  ),
  Expense(
    title: 'Miscellaneous',
    amount: 300,
    date: DateTime.now(),
    categroy: Category.other,
  ),
];

  void _openAddExpenseOverlay(){
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context, 
      builder: (ctx) {
        return NewExpense(
          onAddExpense: _addExpense,
        );
      },
    );
  }

  void _addExpense(Expense expense){
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense){
    final expenseIndex=_registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Expense deleted'),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'Undo'
        , onPressed: (){
          setState(() {
            _registeredExpenses.insert(expenseIndex, expense);
          });
        }),
      )
    );

  }
  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.of(context).size.width;
    // print(width);
    Widget mainContent=Center(
      child: Text('No Expense found.Start adding expense!'),
    );

    if(_registeredExpenses.isNotEmpty){{
      mainContent=ExpensesList(expenses: _registeredExpenses, onRemoveExpense: _removeExpense);
    }}

    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Tracker'),
        actions: [
          IconButton(onPressed: _openAddExpenseOverlay,
           icon: Icon(Icons.add),),
        ],
      ),
      body:width<600? Column(
        children: [
          Expanded(child: Chart(expenses: _registeredExpenses)),
          Expanded(child: mainContent)
        ],
      ):Row(
        children: [
          Expanded(child: Chart(expenses: _registeredExpenses)),
          Expanded(child: mainContent)
        ],
      )
    );
  }
}