//package imports
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

//provider file
import '../providers/todo_provider.dart';

class NewTodo extends StatefulWidget {
  final Function addTd;
  NewTodo(this.addTd);
  @override
  _NewTodoState createState() => _NewTodoState();
}

class _NewTodoState extends State<NewTodo> {
  final _titleController = TextEditingController();
  DateTime _selectedDate;

  void _submitData() {
    print('Flutter');
    final entertedTitle = _titleController.text;
    if (entertedTitle.isEmpty || _selectedDate == null) {
      return;
    }
    widget.addTd(entertedTitle, _selectedDate);
    print('Hello');
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime(2070))
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
          left: 30,
          right: 30,
          bottom: MediaQuery.of(context).viewInsets.bottom,
          top: 30,
        ),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: _titleController,
              onSubmitted: (_) => _submitData(),
            ),
            Container(
              height: 150,
              child: Row(
                children: [
                  Expanded(
                    child: Text(_selectedDate == null
                        ? 'No Date Chosen!'
                        : 'Picked Date: ${DateFormat('yMd').format(_selectedDate)}'),
                  ),
                  RaisedButton(
                    onPressed: () {
                      _presentDatePicker();
                    },
                    color: Colors.teal[700],
                    child: Text(
                      'Choose Date',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                RaisedButton(
                  onPressed: () {
                    Provider.of<TodoProvider>(context, listen: false).addTodos(
                        DateTime.now().toString(),
                        _titleController.text,
                        _selectedDate);
                    _submitData();
                    Provider.of<TodoProvider>(context, listen: false)
                        .getTodos();
                  },
                  child: Text(
                    'Add Todo',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  color: Colors.teal[700],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
