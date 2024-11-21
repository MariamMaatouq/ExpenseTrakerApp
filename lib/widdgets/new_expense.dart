import 'package:flutter/material.dart';
import '../../models/expens.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.AddExpense});

  final void Function(Expense expense) AddExpense;


  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  late TextEditingController _titleController;
  late TextEditingController _amountController;
  DateTime? _selectedDate;
  Category _selectedCategory = Category.food;

  void _validateData() {
    final amount = double.tryParse(_amountController.text);
    final inValidAmount = amount == null || amount <= 0;
    if (_titleController.text.trim().isEmpty ||
        inValidAmount ||
        _selectedDate == null) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            'Invalid Input',
            style: TextStyle(color: Colors.red[900]),
          ),
          content: Text(
            'Please make sure a valid title , amount and  date was enterd  ',
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Ok'))
          ],
        ),
      );
      return;
    }
    widget.AddExpense(Expense(
        title: _titleController.text,
        amount: amount,
        date: _selectedDate!,
        category: _selectedCategory));
    Navigator.pop(context);
  }
  void _datePacker() async {
    final init = DateTime.now();
    final first = DateTime(init.year - 1, init.month, init.day);
    final pickedDate = await showDatePicker(
        context: context, firstDate: first, lastDate: init);
    setState(() {
      _selectedDate = pickedDate;
    });
  }
  @override
  void initState() {
    _titleController = TextEditingController();
    _amountController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16,50,16,16),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            maxLength: 50,
            decoration: InputDecoration(
              label: Text('Title'),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    prefixText: '\$ ',
                    label: Text('Amount'),
                  ),
                ),
              ),
              SizedBox(
                width: 16,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(_selectedDate == null
                        ? 'No selected Date'
                        : formatter.format(_selectedDate!)),
                    IconButton(
                        onPressed: _datePacker,
                        icon: Icon(Icons.calendar_month))
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: 16,
          ),
          Row(
            children: [
              DropdownButton(
                  value: _selectedCategory,
                  items: Category.values
                      .map(
                        (category) => DropdownMenuItem(
                          value: category,
                          child: Text(
                            category.name.toUpperCase(),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }
                    setState(() {
                      _selectedCategory = value;
                    });
                  }),
              Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel'),
              ),
              ElevatedButton(
                  onPressed: _validateData, child: Text('Save Expense')),
            ],
          ),
        ],
      ),
    );
  }
}
