//package imports
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

//provider file imports
import '../providers/todo_provider.dart';
//model import
import '../models/todo_model.dart';
//screen imports
import './NewTodo.dart';
import 'TodoList.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Todos> _userTodos = [];

  //method to add new todo
  void _addNewTodo(String tdTitle, DateTime chosenDate) {
    print('Flutter pressed');
    final newTd = Todos(
        id: DateTime.now().toString(),
        title: tdTitle,
        date: DateFormat("yyyy-MM-dd").format(chosenDate));
    setState(() {
      _userTodos.add(newTd);
    });
  }

  //method to delete a todo
  void _deleteTodo(String id) {
    TodoProvider deleteProvider = Provider.of<TodoProvider>(context, listen: false);
    deleteProvider.deleteTodos(id);
  }

  void _openModelBottomSheet(BuildContext ctx) {
    showModalBottomSheet(
      barrierColor: Colors.teal.withOpacity(0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20)
        ),
      ),
      isScrollControlled: true,
        context: ctx,
        builder: (_) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () {},
                child: NewTodo(_addNewTodo),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Center(child: Text('My Todos', style: TextStyle(color: Colors.white, fontSize: 20.0))),
              decoration: BoxDecoration(
                color: Colors.teal,
              ),
            ),
            ListTile(
              title: Text('BMI Calculator'),
              subtitle: Text('Soon'),
              leading: IconButton(
                icon: Icon(Icons.accessibility),
                onPressed: (){},
              ),
              onTap: () {},
            ),
            Divider(
              height: 10,
            ),
            ListTile(
              title: Text('Calculator'),
              subtitle: Text('Soon'),
              leading: IconButton(
                icon: Icon(Icons.calculate),
                onPressed: (){},
              ),
              onTap: () {},
            ),
            Divider(
              height: 10,
            ),
            ListTile(
              title: Text('Birthday Reminder'),
              subtitle: Text('Soon'),
              leading: IconButton(
                icon: Icon(Icons.wallet_giftcard),
                onPressed: (){},
              ),
              onTap: () {},
            ),
            Divider(
              height: 10,
            ),
          ],
        ),
      ),
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(Icons.brightness_6),
              color: Colors.white,
              onPressed: () {
                TodoProvider themeProvider =
                    Provider.of<TodoProvider>(context, listen: false);
                themeProvider.swapTheme();
                print('hello');
              })
        ],
        title: Text(
          'My Todo App',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [TodoList(_userTodos, _deleteTodo)],
          ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            color: Colors.white,
            size: 30.0,
          ),
          onPressed: () {
            _openModelBottomSheet(context);
          }),
    );
  }
}
