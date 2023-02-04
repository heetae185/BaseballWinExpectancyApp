import 'package:baseball_win_expectancy/providers/probs_sqlite.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:baseball_win_expectancy/screens/screen_baseball.dart';
import 'package:baseball_win_expectancy/models/base.dart';
import 'package:baseball_win_expectancy/models/probs.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) =>
                Base(firstBase: false, secondBase: false, thirdBase: false)),
        ChangeNotifierProvider(
            create: (_) => Probs(
                homeAway: 0,
                topBottom: 0,
                inning: 1,
                outCount: 0,
                situation: 1,
                margin: 0,
                games: 0,
                gamesWon: 0,
                winExpectancy: 0)),
      ],
      builder: (context, child) {
        return MaterialApp(
          title: 'Baseball Win Expectancy',
          initialRoute: '/',
          routes: {'/': (context) => BaseballScreen()},
        );
      },
    );
  }
}
