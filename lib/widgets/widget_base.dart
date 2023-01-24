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
  ProbsSqlite probsSqlite = ProbsSqlite();

  @override
  void initState() {
    super.initState();
    print('initState');
  }

  @override
  Widget build(BuildContext context) {
    late int situationCode;
    final base = Provider.of<Base>(context);
    final probs = Provider.of<Probs>(context);
    late Probs newProb;
    return Column(
      children: [
        MaterialButton(
          onPressed: () async {
            setState(() {
              firstBase = !firstBase;
            });
            base.switchFirstBase();
            probs.changeSituation(base.toSituationCode());
            newProb = await probsSqlite.getProb(probs.homeAway, probs.inning,
                probs.outCount, probs.situation, probs.margin);
            probs.setResults(
                newProb.games, newProb.gamesWon, newProb.winExpectancy);
            print(probs.winExpectancy);
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
            probs.changeSituation(base.toSituationCode());
            newProb = await probsSqlite.getProb(probs.homeAway, probs.inning,
                probs.outCount, probs.situation, probs.margin);
            probs.setResults(
                newProb.games, newProb.gamesWon, newProb.winExpectancy);
            print(probs.winExpectancy);
          },
          color: secondBase ? Colors.blue : Colors.white,
        ),
        MaterialButton(
          onPressed: () async {
            setState(() {
              thirdBase = !thirdBase;
            });
            base.switchThirdBase();
            probs.changeSituation(base.toSituationCode());
            newProb = await probsSqlite.getProb(probs.homeAway, probs.inning,
                probs.outCount, probs.situation, probs.margin);
            probs.setResults(
                newProb.games, newProb.gamesWon, newProb.winExpectancy);
            print(probs.winExpectancy);
          },
          color: thirdBase ? Colors.green : Colors.white,
        ),
      ],
    );
  }
}
