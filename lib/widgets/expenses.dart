import 'package:app/model/widget/chart/chart.dart';
import 'package:app/widgets/expense_list/expense_list.dart';
import 'package:app/widgets/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:app/model/expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
        title: 'Laptop',
        amount: 170000,
        category: Category.work,
        date: DateTime.now()),
    Expense(
        title: 'Phone',
        amount: 180000,
        category: Category.work,
        date: DateTime.now()),
    Expense(
        title: 'clothes',
        amount: 100000,
        category: Category.leisure,
        date: DateTime.now())
  ];
  _openAddExpenseOverlay() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) => NewExpense(onAddExpense: _addExpense));
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 3),
      content: const Text('Expense deleted'),
      action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenseIndex, expense);
            });
          }),
    ));
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child: Text('NO EXPENSES FOUND, START ADDING SOME!'),
    );
    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpenseList(
        expenses: _registeredExpenses,
        onRemovedExpense: _removeExpense,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'MoneyMap',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 79, 38, 3),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
            color: Colors.white,
          )
        ],
      ),
      body: Column(
        children: [
          Chart(
            expenses: _registeredExpenses,
          ),
          Expanded(
            child: mainContent,
          ),
        ],
      ),
    );
  }
}
