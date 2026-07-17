import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();//unique date in string
final formatter = DateFormat.yMd();//intl for date formating

enum Category {
  food,
  travel,
  shopping,
  entertainment,
  health,
  education,
  work,
  bills,
  groceries,
  other,
}

const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.shopping: Icons.shopping_bag,
  Category.entertainment: Icons.movie,
  Category.health: Icons.favorite,
  Category.education: Icons.school,
  Category.work: Icons.work,
  Category.bills: Icons.receipt_long,
  Category.groceries: Icons.local_grocery_store,
  Category.other: Icons.category,
};

class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.categroy,
  }) : id = uuid.v4();

  final String id;
  final String title;
  final DateTime date;
  final double amount;
  final Category categroy;

  String get formattedDate {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  const ExpenseBucket({required this.category, required this.expenses});

  

  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
    : expenses = allExpenses
          .where((expense) => expense.categroy == category)
          .toList();

  final Category category;
  final List<Expense> expenses;


  double get totalExpenses {
    double sum = 0;

    for (final expense in expenses) {
      sum += expense.amount; // sum = sum + expense.amount
    }

    return sum;
  }
}
