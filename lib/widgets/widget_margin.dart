import 'package:flutter/material.dart';
import 'package:baseball_win_expectancy/models/probs.dart';
import 'package:baseball_win_expectancy/providers/sqlite_helper.dart';
import 'package:provider/provider.dart';

class MarginWidget extends StatefulWidget {
  @override
  _MarginWidgetState createState() => _MarginWidgetState();
}

class _MarginWidgetState extends State<MarginWidget> {
  int margin = 0;
  SqliteHelper sqliteHelper = SqliteHelper();

  @override
  void initState() {
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
    return Container(
      child: Column(children: [
        Text(
          '점수 차이',
          style: TextStyle(fontSize: 16),
        ),
        Container(
          child: Row(children: [
            ElevatedButton(
                onPressed: () async {
                  setState(() {
                    margin -= 1;
                  });
                  probsProvider.changeMargin(margin);
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
                child: Text('-')),
            Text(margin.toString()),
            ElevatedButton(
                onPressed: () async {
                  setState(() {
                    margin += 1;
                  });
                  probsProvider.changeMargin(margin);
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
                child: Text('+'))
          ]),
        )
      ]),
    );
  }
}
