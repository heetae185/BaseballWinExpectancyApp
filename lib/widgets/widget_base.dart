import 'package:baseball_win_expectancy/providers/sqlite_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:baseball_win_expectancy/models/base.dart';
import 'package:baseball_win_expectancy/models/probs.dart';
import 'package:baseball_win_expectancy/providers/probs_sqlite.dart';

class BaseWidget extends StatefulWidget {
  @override
  _BaseWidgetState createState() => _BaseWidgetState();
}

class _BaseWidgetState extends State<BaseWidget> {
  bool firstBase = false;
  bool secondBase = false;
  bool thirdBase = false;
  SqliteHelper sqliteHelper = SqliteHelper();

  @override
  void initState() {
    super.initState();
    print('initState');
  }

  Future getProb(int homeAway, int topBottom, int inning, int outCount,
      int situation, int margin) async {
    final probDb = await sqliteHelper.getProb(
        homeAway, topBottom, inning, outCount, situation, margin);
    return probDb;
  }

  @override
  Widget build(BuildContext context) {
    final base = Provider.of<Base>(context);
    final probsProvider = Provider.of<Probs>(context);
    late Probs newProb;
    return Column(
      children: [
        MaterialButton(
          onPressed: () async {
            setState(() {
              firstBase = !firstBase;
            });
            base.switchFirstBase();
            probsProvider.changeSituation(base.toSituationCode());
            newProb = await getProb(
                probsProvider.homeAway,
                probsProvider.topBottom,
                probsProvider.inning,
                probsProvider.outCount,
                probsProvider.situation,
                probsProvider.margin);
            probsProvider.setResults(
                newProb.games, newProb.gamesWon, newProb.winExpectancy);
            print(probsProvider.winExpectancy);
            print(base.firstBase);
          },
          color: firstBase ? Colors.red : Colors.white,
        ),
        MaterialButton(
          onPressed: () async {
            setState(() {
              secondBase = !secondBase;
            });
            base.switchSecondBase();
            probsProvider.changeSituation(base.toSituationCode());
            newProb = await getProb(
                probsProvider.homeAway,
                probsProvider.topBottom,
                probsProvider.inning,
                probsProvider.outCount,
                probsProvider.situation,
                probsProvider.margin);
            probsProvider.setResults(
                newProb.games, newProb.gamesWon, newProb.winExpectancy);
            print(probsProvider.winExpectancy);
          },
          color: secondBase ? Colors.blue : Colors.white,
        ),
        MaterialButton(
          onPressed: () async {
            setState(() {
              thirdBase = !thirdBase;
            });
            base.switchThirdBase();
            probsProvider.changeSituation(base.toSituationCode());
            newProb = await getProb(
                probsProvider.homeAway,
                probsProvider.topBottom,
                probsProvider.inning,
                probsProvider.outCount,
                probsProvider.situation,
                probsProvider.margin);
            probsProvider.setResults(
                newProb.games, newProb.gamesWon, newProb.winExpectancy);
            print(probsProvider.winExpectancy);
          },
          color: thirdBase ? Colors.green : Colors.white,
        ),
      ],
    );
  }
}
