import 'package:baseball_win_expectancy/providers/probs_sqlite.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:baseball_win_expectancy/providers/probs_sqlite.dart';
import 'package:baseball_win_expectancy/models/probs.dart';

class BaseballScreen extends StatefulWidget {
  @override
  _BaseballScreenState createState() => _BaseballScreenState();
}

class _BaseballScreenState extends State<BaseballScreen> {
  ProbsSqlite probsSqlite = ProbsSqlite();
  bool isLoading = true;
  String tempString = '';
  List<Probs> probs = [];
  late Probs prob;
  late int homeAway;
  late int inning;
  late int outCount;
  bool firstBase = false;
  bool secondBase = false;
  bool thirdBase = false;

  Future initDb() async {
    await probsSqlite.initDb().then((value) async {
      prob = await probsSqlite.getProb(1, 1, 0, 1, 0);
    });
  }

  @override
  void initState() {
    super.initState();
    print('initState');
    Timer(Duration(seconds: 1), () {
      initDb().then((_) {
        setState(() {
          isLoading = false;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Baseball Win Expectancy')),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(children: [
                TextButton(
                  child: Text('실험'),
                  onPressed: () async {
                    Probs newProb = await probsSqlite.getProb(0, 1, 0, 1, 0);
                    setState(() {
                      prob = newProb;
                    });
                  },
                ),
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(prob.homeAway.toString()),
                  Text(prob.inning.toString()),
                  Text(prob.games.toString()),
                  Text(prob.gamesWon.toString()),
                  Text(prob.winExpectancy.toString())
                ])
              ]));
  }
}
