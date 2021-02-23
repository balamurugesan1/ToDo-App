//package imports
import 'package:flutter/foundation.dart';
// import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// models import
import '../models/todo_model.dart';
import '../helpers/db_helper.dart';

class TodoProvider extends ChangeNotifier {
  bool isDarkModeOn = false;
  //light theme
  ThemeData _selectedTheme;
  ThemeData light = ThemeData.light().copyWith(
      appBarTheme: AppBarTheme(
        color: Colors.teal[700],
        titleSpacing: 5.0,
        centerTitle: true,
      ),
      primaryColor: Colors.teal[700],
      accentColor: Colors.teal[700],
      floatingActionButtonTheme:
          FloatingActionButtonThemeData(backgroundColor: Colors.teal[700]));
  //dark theme
  ThemeData dark = ThemeData.dark().copyWith(
      appBarTheme: AppBarTheme(
        titleSpacing: 5.0,
        centerTitle: true,
      ),
      accentColor: Colors.black,
      floatingActionButtonTheme:
          FloatingActionButtonThemeData(backgroundColor: Colors.black));
  TodoProvider({bool isDarkModeOn}) {
    _selectedTheme = isDarkModeOn ? light : dark;
  }
  //methdos to swap theme
  void swapTheme() {
    _selectedTheme = _selectedTheme == dark ? light : dark;
    notifyListeners();
  }

  ThemeData get getTheme => _selectedTheme;

  List<Todos> todoListItems = [];

  //add todo
  addTodos(String id, String title, DateTime date) async {
    final newTodo = Todos(
        id: DateTime.now().toString(),
        title: title,
        date: DateFormat("yyyy-MM-dd").format(date));
    DBHelper.insert('user_todo',
        {'id': newTodo.id, 'title': newTodo.title, 'date': newTodo.date});
    notifyListeners();
  }

  //delete todos
  deleteTodos(String id) async {
    await DBHelper.deleteTodos(id);
    todoListItems.removeWhere((item) => item.id == id);
    notifyListeners();
  }

  //get todo from database
  bool isLoading = true;
  Future<void> getTodos() async {
    isLoading = true;
    todoListItems = [];
    final dataList = await DBHelper.getData('user_todo');
    // print('Pressed $dataList');
    dataList.forEach((element) {
      todoListItems.add(Todos(
          id: element['id'], title: element['title'], date: element['date'].toString()
          // date: DateTime.fromMillisecondsSinceEpoch(
          //     int.parse(element['date'].toString())

          //     )
          )); 
    });
    // print(todoListItems); 
    // _todoListItems = dataList
    //     .map((item) =>
    //         Todos(id: item['id'], title: item['title'], date: item['date']))
    //     .toList();
    isLoading = false;
    notifyListeners();
  }
}
