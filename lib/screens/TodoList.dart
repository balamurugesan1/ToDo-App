import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
// import 'package:todo_app_production/navigation_service.dart';
import '../providers/todo_provider.dart';

import '../models/todo_model.dart';

class TodoList extends StatefulWidget {
  final List<Todos> todo;
  final Function deleteTd;

  TodoList(this.todo, this.deleteTd);

  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  @override
  void initState() {
    // Provider.of<TodoProvider>(NavService.navKey.currentContext, listen: false)
    //     .getTodos();
    // super.initState();
  }

  void _showSnackBar() {
    Get.snackbar(
      'Todo has been deleted',
      '',
      backgroundColor: Colors.teal,
      dismissDirection: SnackDismissDirection.HORIZONTAL,
      duration: Duration(seconds: 2),
      snackPosition: SnackPosition.BOTTOM,
      colorText: Colors.white,
      animationDuration: Duration(seconds: 2),
      isDismissible: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (ctx, snapshot) => snapshot.connectionState ==
              ConnectionState.waiting
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Consumer<TodoProvider>(
              builder: (context, todoProvider, child) {
                // Provider.of<TodoProvider>(NavService.navKey.currentContext,
                //         listen: false)
                //     .getTodos();
                return todoProvider.todoListItems.isEmpty
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                              child: Text('Add your Todo',
                                  style: TextStyle(
                                      color: Colors.teal[500],
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30))),
                        ],
                      )
                    : ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (ctx, index) {
                          return Card(
                            color: Colors.teal,
                            shadowColor: Theme.of(context).accentColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            elevation: 5,
                            margin: EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 5,
                            ),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 30,
                                child: Padding(
                                  padding: EdgeInsets.all(6),
                                  child: FittedBox(
                                    child: Text(
                                      '${todoProvider.todoListItems[index].title.substring(0, 1).toUpperCase()}',
                                      style: TextStyle(
                                          color: Colors.teal, fontSize: 25),
                                    ),
                                  ),
                                ),
                              ),
                              title: Text(
                                todoProvider.todoListItems[index].title,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              subtitle: Text(
                                '${todoProvider.todoListItems[index].date}',
                                // DateFormat.yMd().format(todo[index].date),
                                style: TextStyle(color: Colors.white),
                              ),
                              trailing: IconButton(
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    widget.deleteTd(
                                        todoProvider.todoListItems[index].id);
                                    _showSnackBar();
                                  }),
                            ),
                          );
                        },
                        itemCount: todoProvider.todoListItems.length);
              },
            ),
    );
  }
}
