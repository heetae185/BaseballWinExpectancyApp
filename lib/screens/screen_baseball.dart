import 'package:baseball_win_expectancy/providers/probs_sqlite.dart';
import 'package:baseball_win_expectancy/providers/sqlite_helper.dart';
import 'package:baseball_win_expectancy/widgets/widget_homeAway.dart';
import 'package:baseball_win_expectancy/widgets/widget_inning.dart';
import 'package:baseball_win_expectancy/widgets/widget_outCount.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:baseball_win_expectancy/models/probs.dart';
import 'package:baseball_win_expectancy/widgets/widget_base.dart';
import 'package:baseball_win_expectancy/models/base.dart';
import 'package:provider/provider.dart';

class BaseballScreen extends StatefulWidget {
  @override
  _BaseballScreenState createState() => _BaseballScreenState();
}

class _BaseballScreenState extends State<BaseballScreen> {
  late SqliteHelper sqliteHelper;
  bool isLoading = true;
  String tempString = '';
  List<Probs> probs = [];
  late Probs prob;
  late int homeAway;
  late int topBottom;
  late int inning;
  late int outCount;
  bool firstBase = false;
  bool secondBase = false;
  bool thirdBase = false;

  Future getProb(int homeAway, int topBottom, int inning, int outCount,
      int situation, int margin) async {
    final probDb = await sqliteHelper.getProb(
        homeAway, topBottom, inning, outCount, situation, margin);
    return probDb;
  }

  Future initDb() async {
    var db = await ProbsSqlite.instance.database;
    prob = await getProb(0, 0, 1, 0, 1, 0);
  }

  @override
  void initState() {
    super.initState();
    print('initState');
    sqliteHelper = SqliteHelper();
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
    final probsProvider = Provider.of<Probs>(context);
    final base = Provider.of<Base>(context);

    return Scaffold(
        appBar: AppBar(title: Text('Baseball Win Expectancy')),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(children: [
                HomeAwayWidget(),
                InningWidget(),
                BaseWidget(),
                OutCountWidget(),
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(probsProvider.homeAway.toString()),
                  Text(probsProvider.inning.toString()),
                  Text(probsProvider.games.toString()),
                  Text(probsProvider.gamesWon.toString()),
                  Text(probsProvider.winExpectancy.toString())
                ]),
              ]));
  }
}
