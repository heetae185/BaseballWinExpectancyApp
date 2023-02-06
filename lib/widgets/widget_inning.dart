import 'package:baseball_win_expectancy/providers/sqlite_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:baseball_win_expectancy/models/probs.dart';

class InningWidget extends StatefulWidget {
  @override
  _InningWidgetState createState() => _InningWidgetState();
}

class _InningWidgetState extends State<InningWidget> {
  int _value = 1;
  SqliteHelper sqliteHelper = SqliteHelper();

  @override
  void initState() {
    super.initState();
    print('iniState');
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
    List<int> inning = [1, 2, 3, 4, 5, 6, 7, 8, 9];
    return Container(
        child: Column(
      children: [
        Row(
          children: [
            Padding(padding: EdgeInsets.only(left: 30)),
            for (var i in inning)
              Container(
                width: 30,
                height: 20,
                child: Text(
                  i.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            Container(
              width: 30,
              height: 20,
              child: Text(
                'OT',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            )
          ],
        ),
        Row(
          children: [
            Container(
              width: 30,
              height: 30,
              child: Text(
                '초',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ),
            for (var i in inning)
              InningRadioButtons<int>(
                  value: i,
                  groupValue: _value,
                  onChanged: (value) async {
                    setState(() {
                      _value = value!;
                      probsProvider.changeInningTopBottom(value);
                    });
                    newProb = await getProb(
                        probsProvider.homeAway,
                        probsProvider.topBottom,
                        probsProvider.inning,
                        probsProvider.outCount,
                        probsProvider.situation,
                        probsProvider.margin);
                    probsProvider.setResults(
                        newProb.games, newProb.gamesWon, newProb.winExpectancy);
                  }),
            InningRadioButtons<int>(
                value: 10,
                groupValue: _value,
                onChanged: (value) async {
                  setState(() {
                    _value = value!;
                    probsProvider.changeInningTopBottom(value);
                  });
                  newProb = await getProb(
                      probsProvider.homeAway,
                      probsProvider.topBottom,
                      probsProvider.inning,
                      probsProvider.outCount,
                      probsProvider.situation,
                      probsProvider.margin);
                  probsProvider.setResults(
                      newProb.games, newProb.gamesWon, newProb.winExpectancy);
                }),
          ],
        ),
        Row(
          children: [
            Container(
              width: 30,
              height: 30,
              child: Text(
                '말',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ),
            for (var i in inning)
              InningRadioButtons<int>(
                  value: i + 10,
                  groupValue: _value,
                  onChanged: (value) async {
                    setState(() {
                      _value = value!;
                      probsProvider.changeInningTopBottom(value);
                    });
                    newProb = await getProb(
                        probsProvider.homeAway,
                        probsProvider.topBottom,
                        probsProvider.inning,
                        probsProvider.outCount,
                        probsProvider.situation,
                        probsProvider.margin);
                    probsProvider.setResults(
                        newProb.games, newProb.gamesWon, newProb.winExpectancy);
                  }),
            InningRadioButtons<int>(
                value: 20,
                groupValue: _value,
                onChanged: (value) async {
                  setState(() {
                    _value = value!;
                    probsProvider.changeInningTopBottom(value);
                  });
                  newProb = await getProb(
                      probsProvider.homeAway,
                      probsProvider.topBottom,
                      probsProvider.inning,
                      probsProvider.outCount,
                      probsProvider.situation,
                      probsProvider.margin);
                  probsProvider.setResults(
                      newProb.games, newProb.gamesWon, newProb.winExpectancy);
                }),
          ],
        )
      ],
    ));
  }
}

class InningRadioButtons<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final ValueChanged<T?> onChanged;

  const InningRadioButtons(
      {required this.value, required this.groupValue, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged(value),
      child: Container(
        height: 30,
        width: 30,
        padding: EdgeInsets.all(5),
        child: _customRadioButton,
      ),
    );
  }

  Widget get _customRadioButton {
    final isSelected = value == groupValue;
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: isSelected ? Colors.green : null,
          borderRadius: BorderRadius.circular(3),
          border: Border.all(
            color: isSelected ? Colors.green : Colors.grey[300]!,
            width: 2,
          )),
    );
  }
}
