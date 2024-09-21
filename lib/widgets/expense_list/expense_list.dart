import 'package:app/widgets/expense_list/expense_item.dart';
import 'package:app/model/expense.dart';
import 'package:flutter/material.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList(
      {super.key, required this.expenses, required this.onRemovedExpense});

  final List<Expense> expenses;
  final void Function(Expense expense) onRemovedExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (ctx, index) => Dismissible(key: ValueKey(expenses[index]), 
        onDismissed: (direction){
          onRemovedExpense(expenses[index]);
        },
        child: ExpenseItem(
          expenses[index],
        ),
        )
        );
  }
}
