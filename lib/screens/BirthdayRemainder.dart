import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/todo_provider.dart';


class BirthdayRemainder extends StatelessWidget {
  static const routeName = '/birthday-remainder';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        actions: [
          IconButton(
              icon: Icon(Icons.brightness_6),
              color: Colors.white,
              onPressed: () {
                TodoProvider themeProvider =
                    Provider.of<TodoProvider>(context, listen: false);
                themeProvider.swapTheme();
              })
        ],
        title: Text(
          'Birthday Remainder',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Text('Birthday Remainder')
        ],
      ),
    );
  }
}