import 'package:baseball_win_expectancy/providers/sqlite_helper.dart';
import 'package:flutter/material.dart';
import 'package:baseball_win_expectancy/models/probs.dart';
import 'package:provider/provider.dart';

class HomeAwayWidget extends StatefulWidget {
  @override
  _HomeAwayWidgetState createState() => _HomeAwayWidgetState();
}

class _HomeAwayWidgetState extends State<HomeAwayWidget> {
  // if home team then homeAway == 0, else if away team then homeAway == 1
  int homeAway = 0;
  late List<bool> isSelected;
  SqliteHelper sqliteHelper = SqliteHelper();

  @override
  void initState() {
    super.initState();
    print('iniState');
    isSelected = [true, false];
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
      color: Colors.white,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text(
          '우리팀은',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20),
        ),
        Container(
          child: Center(
            child: ToggleButtons(
                selectedColor: Colors.white,
                fillColor: Colors.green,
                children: [
                  const Text(
                    '홈팀',
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'SpoqaHanSansNeo',
                        fontWeight: FontWeight.w400),
                  ),
                  const Text(
                    '원정팀',
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'SpoqaHanSansNeo',
                        fontWeight: FontWeight.w400),
                  ),
                ],
                constraints: BoxConstraints(
                    minWidth: (MediaQuery.of(context).size.width - 30) / 2),
                onPressed: (int index) async {
                  setState(() {
                    for (int i = 0; i < isSelected.length; i++) {
                      isSelected[i] = i == index;
                      homeAway = index;
                    }
                  });
                  probsProvider.changeHomeAway(homeAway);
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
                isSelected: isSelected),
          ),
        ),
        const Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 10))
      ]),
    );
  }
}
