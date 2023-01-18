import 'package:flutter/material.dart';
import 'package:baseball_win_expectancy/screens/screen_baseball.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Baseball Win Expectancy', home: BaseballScreen());
  }
}
