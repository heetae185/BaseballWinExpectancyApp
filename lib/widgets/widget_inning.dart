import 'package:baseball_win_expectancy/providers/sqlite_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:baseball_win_expectancy/models/probs.dart';
import 'package:numberpicker/numberpicker.dart';

class InningWidget extends StatefulWidget {
  @override
  _InningWidgetState createState() => _InningWidgetState();
}

class _InningWidgetState extends State<InningWidget> {
  int _currentInningValue = 1;
  int _topBottomValue = 0;
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

    double inningPickerMarginWidth = MediaQuery.of(context).size.width * 0.05;
    double inningPickerWidth = MediaQuery.of(context).size.width * 0.8;
    List<int> inning = [1, 2, 3, 4, 5, 6, 7, 8, 9];

    return Container(
      color: Colors.white,
      margin: EdgeInsets.fromLTRB(
          inningPickerMarginWidth, 0, inningPickerMarginWidth, 0),
      width: inningPickerWidth,
      child: Row(children: [
        SizedBox(
          width: inningPickerWidth * 0.05,
        ),
        Container(
          alignment: Alignment.center,
          width: inningPickerWidth * 0.2,
          child: Text(
            '지금은',
            style: TextStyle(fontSize: 18),
          ),
        ),
        SizedBox(
          width: inningPickerWidth * 0.2,
          child: NumberPicker(
            minValue: 1,
            maxValue: 10,
            value: _currentInningValue,
            itemHeight: 25,
            itemWidth: 50,
            selectedTextStyle: TextStyle(
                fontSize: 18,
                fontFamily: 'SpoqaHanSansNeo',
                fontWeight: FontWeight.w600,
                color: Colors.black),
            textStyle: TextStyle(
                fontSize: 12,
                fontFamily: 'SpoqaHanSansNeo',
                fontWeight: FontWeight.w400,
                color: Colors.grey),
            infiniteLoop: true,
            onChanged: (value) async {
              setState(() {
                _currentInningValue = value;
                probsProvider.changeInning(_currentInningValue);
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
            },
            textMapper: (numberText) {
              if (numberText == '10') {
                return '연장';
              } else {
                return numberText;
              }
            },
          ),
        ),
        Container(
          alignment: Alignment.center,
          width: inningPickerWidth * 0.1,
          child: Text(
            '회',
            style: TextStyle(
                fontSize: 18,
                fontFamily: 'SpoqaHanSansNeo',
                fontWeight: FontWeight.w600),
          ),
        ),
        SizedBox(
          width: inningPickerWidth * 0.2,
          child: NumberPicker(
            minValue: 0,
            maxValue: 1,
            value: _topBottomValue,
            itemHeight: 25,
            itemWidth: 50,
            selectedTextStyle: TextStyle(
                fontSize: 18,
                fontFamily: 'SpoqaHanSansNeo',
                fontWeight: FontWeight.w600,
                color: Colors.black),
            textStyle: TextStyle(
                fontSize: 14,
                fontFamily: 'SpoqaHanSansNeo',
                fontWeight: FontWeight.w400,
                color: Colors.grey),
            infiniteLoop: false,
            onChanged: (value) async {
              setState(() {
                _topBottomValue = value;
                probsProvider.changeTopBottom(_topBottomValue);
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
            },
            textMapper: ((numberText) {
              if (numberText == '0') {
                return '초';
              } else {
                return '말';
              }
            }),
          ),
        ),
        Container(
          alignment: Alignment.center,
          width: inningPickerWidth * 0.2,
          child: Text(
            '입니다',
            style: TextStyle(fontSize: 18),
          ),
        ),
        SizedBox(
          width: inningPickerWidth * 0.05,
        )
      ]),
    );
  }
}
