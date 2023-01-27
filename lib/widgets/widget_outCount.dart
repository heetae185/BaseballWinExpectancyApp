import 'package:baseball_win_expectancy/providers/sqlite_helper.dart';
import 'package:flutter/material.dart';
import 'package:baseball_win_expectancy/models/probs.dart';
import 'package:provider/provider.dart';

class OutCountWidget extends StatefulWidget {
  @override
  _OutcountWidgetState createState() => _OutcountWidgetState();
}

class _OutcountWidgetState extends State<OutCountWidget> {
  int outCount = 0;
  SqliteHelper sqliteHelper = SqliteHelper();

  @override
  void initState() {
    super.initState();
    print('initState');
  }

  Future getProb(
      int homeAway, int inning, int outCount, int situation, int margin) async {
    final probDb = await sqliteHelper.getProb(
        homeAway, inning, outCount, situation, margin);
    return probDb;
  }

  @override
  Widget build(BuildContext context) {
    final probsProvider = Provider.of<Probs>(context);
    late Probs newProb;
    return GestureDetector(
      onTap: () async {
        setState(() {
          outCount = (++outCount) % 3;
        });
        probsProvider.changeOutCount(outCount);
        newProb = await getProb(
            probsProvider.homeAway,
            probsProvider.inning,
            probsProvider.outCount,
            probsProvider.situation,
            probsProvider.margin);
        probsProvider.setResults(
            newProb.games, newProb.gamesWon, newProb.winExpectancy);
      },
      child: Container(
        width: 100,
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        color: Colors.green,
        child: Row(children: [
          Container(
            height: 20,
            width: 20,
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            decoration: BoxDecoration(
                color: (outCount > 0) ? Colors.red : Colors.white,
                shape: BoxShape.circle),
          ),
          Container(
            height: 20,
            width: 20,
            padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
            decoration: BoxDecoration(
                color: (outCount > 1) ? Colors.red : Colors.white,
                shape: BoxShape.circle),
          )
        ]),
      ),
    );
  }
}
