import 'package:baseball_win_expectancy/providers/probs_sqlite.dart';
import 'package:baseball_win_expectancy/providers/sqlite_helper.dart';
import 'package:baseball_win_expectancy/widgets/widget_homeAway.dart';
import 'package:baseball_win_expectancy/widgets/widget_inning.dart';
import 'package:baseball_win_expectancy/widgets/widget_margin.dart';
import 'package:baseball_win_expectancy/widgets/widget_outCount.dart';
import 'package:baseball_win_expectancy/widgets/widget_result.dart';
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

    double screenHeight = MediaQuery.of(context).size.height -
        (MediaQuery.of(context).padding.top + 50);
    double widthMargin = MediaQuery.of(context).size.width * 0.05;
    double heightMargin = screenHeight * 0.01;

    return Scaffold(
        appBar: AppBar(
          title: Text('Baseball Win Expectancy'),
        ),
        backgroundColor: const Color(0xFFF5F5F5),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(children: [
                Container(
                  margin:
                      EdgeInsets.fromLTRB(0, heightMargin * 2, 0, heightMargin),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  height: screenHeight * 0.12,
                  child: HomeAwayWidget(),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, heightMargin, 0, heightMargin),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)),
                  height: screenHeight * 0.1,
                  child: InningWidget(),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, heightMargin, 0, heightMargin),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(15)),
                  height: screenHeight * 0.28,
                  child: BaseWidget(),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(
                      widthMargin, heightMargin, widthMargin, heightMargin),
                  height: screenHeight * 0.17,
                  child: Row(children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      width: MediaQuery.of(context).size.width * 0.35,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                      child: OutCountWidget(),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.05,
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      width: MediaQuery.of(context).size.width * 0.5,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                      child: MarginWidget(),
                    )
                  ]),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, heightMargin, 0, heightMargin),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)),
                  height: screenHeight * 0.14,
                  child: ResultWidget(),
                ),
                // Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                //   Text(probsProvider.inning.toString()),
                //   Text(probsProvider.games.toString()),
                //   Text(probsProvider.gamesWon.toString()),
                //   Text(probsProvider.winExpectancy.toString())
                // ]),
              ]));
  }
}
