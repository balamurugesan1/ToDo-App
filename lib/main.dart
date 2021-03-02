//package imports
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';


//screens import
import './providers/todo_provider.dart';
import './screens/HomePage.dart';
import './screens/BirthdayRemainder.dart';
import './screens/BmiCalculator.dart';
import './screens/MathCalculator.dart';
import './navigation_service.dart';

void main() {
  runApp((MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setPreferredOrientations([
    //     DeviceOrientation.portraitUp,
    //   ]);
    return ChangeNotifierProvider(
      create: (context) {
        return TodoProvider(isDarkModeOn: true);
      },
      child: Consumer<TodoProvider>(
        builder: (context, themeState, child) {
          return GetMaterialApp(
            navigatorKey: NavService.navKey,
            debugShowCheckedModeBanner: false,
            title: 'My Todos',
            theme: themeState.getTheme,
            home: HomePage(),
            routes: {
              HomePage.routeName: (ctx) => HomePage(),
              BmiCalculator.routeName: (ctx) => BmiCalculator(),
              MathCalculator.routeName: (ctx) => MathCalculator(),
              BirthdayRemainder.routeName: (ctx) => BirthdayRemainder(),
            },
          );
        },
      ),
    );
  }
}
