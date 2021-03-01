import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/todo_provider.dart';

class BmiCalculator extends StatelessWidget {
  static const routeName = '/bmi-calculator';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
          'BMI Calculator',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: RaisedButton(
          color: Colors.red,
          onPressed: (){
              Navigator.of(context).pop();
          },
           child: Text(
            'Back',
            style: TextStyle(color: Colors.white),
          ),
        ),
      )
    );
  }
}

