import 'package:flutter/cupertino.dart';
import 'package:rev_expense_app/models/expense.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _amountController = TextEditingController();
  Category _selectedCategroy = Category.entertainment;
  DateTime? _selectedDate;

  Future<void> _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);

    final pickedDate = await showDatePicker(
      context: context,
      firstDate: firstDate,
      lastDate: now,
    );

    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _showDialog(){
    if(Platform.isIOS){
      showCupertinoDialog(context: context, builder: (context) => CupertinoAlertDialog(
        title: const Text('Invalid Input'),
        content: const Text(
          'Please make sure the title,category,amount,and date was entered is vlid!',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Okay'),
          ),
        ],
      ),);
    }
    else{
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Invalid Input'),
            content: const Text(
              'Please make sure the title,category,amount,and date was entered is vlid!',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Okay'),
              ),
            ],
          );
        },
      );
    }

    //show error

  }

  void _submitExpenseDat() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount < 0;

    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      _showDialog();
      return;
    }

    widget.onAddExpense(
      Expense(
        title: _titleController.text,
        amount: double.parse(_amountController.text),
        date: _selectedDate!,
        categroy: _selectedCategroy,
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyBoardSpace=MediaQuery.of(context).viewInsets.bottom;

    return LayoutBuilder(builder: (ctx, constraints) {
      final width=constraints.maxWidth;

      return  SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, keyBoardSpace+16),
            child: Column(
              children: [
                if (width>=600)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _titleController,
                          maxLength: 50,
                          decoration: InputDecoration(label: Text('Title')),
                        ),
                      ),
                      const SizedBox(width: 24,),
                      Expanded(
                        child: TextField(
                          keyboardType: TextInputType.numberWithOptions(),
                          controller: _amountController,
                          decoration: InputDecoration(label: Text('Amount')),
                        ),
                      ),
                    ],
                  )
                else
                TextField(
                  controller: _titleController,
                  maxLength: 50,
                  decoration: InputDecoration(label: Text('Title')),
                ),
                if(width>=600)
                  Row(
                    children: [
                      DropdownButton<Category>(
                        value: _selectedCategroy,
                        items: Category.values
                            .map(
                              (categroy) => DropdownMenuItem<Category>(
                            value: categroy,
                            child: Text(categroy.name.toUpperCase()),
                          ),
                        )
                            .toList(),
                        onChanged: (value) {
                          if (value == null) {
                            return;
                          }
                          setState(() {
                            _selectedCategroy = value;
                          });
                        },
                      ),
                      const SizedBox(width: 24,),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Date'),
                            IconButton(
                              onPressed: _presentDatePicker,
                              icon: Icon(Icons.calendar_month),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                else
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.numberWithOptions(),
                        controller: _amountController,
                        decoration: InputDecoration(label: Text('Amount'),prefixText: '\$'),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Date'),
                          IconButton(
                            onPressed: _presentDatePicker,
                            icon: Icon(Icons.calendar_month),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                if(width>=600)
                  Row(
                    children: [
                      const Spacer(),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Cancle'),
                      ),
                      ElevatedButton(onPressed: _submitExpenseDat, child: Text('Save')),

                    ],
                  )
                else
                Row(
                  children: [
                    DropdownButton<Category>(
                      value: _selectedCategroy,
                      items: Category.values
                          .map(
                            (categroy) => DropdownMenuItem<Category>(
                          value: categroy,
                          child: Text(categroy.name.toUpperCase()),
                        ),
                      )
                          .toList(),
                      onChanged: (value) {
                        if (value == null) {
                          return;
                        }
                        setState(() {
                          _selectedCategroy = value;
                        });
                      },
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Cancle'),
                    ),
                    ElevatedButton(onPressed: _submitExpenseDat, child: Text('Save')),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },);
  }
}
