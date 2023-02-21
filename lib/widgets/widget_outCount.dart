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

  Future getProb(int homeAway, int topBottom, int inning, int outCount,
      int situation, int margin) async {
    final probDb = await sqliteHelper.getProb(
        homeAway, topBottom, inning, outCount, situation, margin);
    return probDb;
  }

  @override
  Widget build(BuildContext context) {
    final probsProvider = Provider.of<Probs>(context);
    late Probs newProb;
    double outCountWidgetHeight = MediaQuery.of(context).size.height * 0.15;
    double outCountWidgetWidth = MediaQuery.of(context).size.width * 0.35;

    return GestureDetector(
      onTap: () async {
        setState(() {
          outCount = (++outCount) % 3;
        });
        probsProvider.changeOutCount(outCount);
        newProb = await getProb(
            probsProvider.homeAway,
            probsProvider.topBottom,
            probsProvider.inning,
            probsProvider.outCount,
            probsProvider.situation,
            probsProvider.margin);
        probsProvider.setResults(
            newProb.games, newProb.gamesWon, newProb.winExpectancy);
      },
      child: Column(children: [
        SizedBox(
          height: outCountWidgetHeight * 0.2,
        ),
        SizedBox(
          height: outCountWidgetHeight * 0.2,
          child: Text(
            '아웃',
            style: TextStyle(fontSize: 22),
          ),
        ),
        SizedBox(
          height: outCountWidgetHeight * 0.1,
        ),
        SizedBox(
          height: outCountWidgetHeight * 0.3,
          child: Row(children: [
            SizedBox(
              width: outCountWidgetWidth * 0.15,
            ),
            Container(
              width: outCountWidgetWidth * 0.325,
              decoration: BoxDecoration(
                  color: (outCount > 0) ? Colors.red : Colors.white,
                  shape: BoxShape.circle,
                  border: (outCount > 0)
                      ? Border.all(color: Colors.red)
                      : Border.all(color: Color(0xFFC2C2C2), width: 1)),
            ),
            SizedBox(
              width: outCountWidgetWidth * 0.05,
            ),
            Container(
              width: outCountWidgetWidth * 0.325,
              decoration: BoxDecoration(
                  color: (outCount > 1) ? Colors.red : Colors.white,
                  shape: BoxShape.circle,
                  border: (outCount > 1)
                      ? Border.all(color: Colors.red)
                      : Border.all(color: Color(0xFFC2C2C2), width: 1)),
            ),
            SizedBox(
              width: outCountWidgetWidth * 0.15,
            ),
          ]),
        ),
        SizedBox(
          height: outCountWidgetHeight * 0.2,
        )
      ]),
    );
  }
}
