import 'package:app/model/expense.dart';
import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;
  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _seletedDate;
  Category _selectedCategory = Category.education;

  void _datePicker() async {
    final now = DateTime.now();
    final firstdate = DateTime(now.year - 1, now.month, now.day);

    final pickedDate = await showDatePicker(
        context: context, firstDate: firstdate, lastDate: now);

    setState(() {
      _seletedDate = pickedDate;
    });
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _seletedDate == null) {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text('Invalid input'),
                content: const Text(
                    'Please make sure a valid title, amount, date and category was entered'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                      },
                      child: const Text('Okay'))
                ],
              ));
      return;
    }
    widget.onAddExpense(Expense(
        title: _titleController.text,
        amount: enteredAmount,
        category: _selectedCategory,
        date: _seletedDate!));
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
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 72, 16, 16),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            maxLength: 50,
            decoration: const InputDecoration(label: Text('title')),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: _amountController,
                  maxLength: 50,
                  decoration: const InputDecoration(
                      prefixText: '\$', label: Text('amount')),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(_seletedDate == null
                      ? 'no date selected'
                      : formatter.format(_seletedDate!)),
                  IconButton(
                      onPressed: _datePicker,
                      icon: const Icon(Icons.calendar_month))
                ],
              ))
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              DropdownButton(
                  value: _selectedCategory,
                  items: Category.values
                      .map((category) => DropdownMenuItem(
                          value: category,
                          child: Text(
                            category.name.toUpperCase(),
                            style: const TextStyle(
                                color: Color.fromARGB(255, 79, 38, 3)),
                          )))
                      .toList(),
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }
                    setState(() {
                      _selectedCategory = value;
                    });
                  }),
              const Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: TextButton.styleFrom(
                  foregroundColor: const Color.fromARGB(255, 79, 38, 3),
                ),
                child: const Text('cancel'),
              ),
              ElevatedButton(
                onPressed: _submitExpenseData,
                style: ElevatedButton.styleFrom(foregroundColor: const Color.fromARGB(255, 79, 38, 3)),
                child: const Text('save expense'),
              )
            ],
          ),
          const SizedBox(
            height: 300,
          ),
        ],
      ),
    );
  }
}
