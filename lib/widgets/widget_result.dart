import 'package:flutter/cupertino.dart';
import 'package:baseball_win_expectancy/providers/sqlite_helper.dart';
import 'package:baseball_win_expectancy/models/probs.dart';
import 'package:provider/provider.dart';

class ResultWidget extends StatelessWidget {
  SqliteHelper sqliteHelper = SqliteHelper();

  @override
  Widget build(BuildContext context) {
    final probsProvider = Provider.of<Probs>(context);
    double screenHeight = MediaQuery.of(context).size.height -
        (MediaQuery.of(context).padding.top + 50);
    double resultWidgetMarginWidth = MediaQuery.of(context).size.width * 0.05;
    double resultWidgetWidth = MediaQuery.of(context).size.width * 0.8;
    double resultWidgetHeight = screenHeight * 0.14;

    return Container(
      margin: EdgeInsets.fromLTRB(
          resultWidgetMarginWidth, 0, resultWidgetMarginWidth, 0),
      width: resultWidgetWidth,
      child: Row(children: [
        SizedBox(
          width: resultWidgetWidth * 0.7,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '같은 상황 ',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text('${probsProvider.games}',
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'SpoqaHanSansNeo',
                            fontWeight: FontWeight.w600)),
                    Text('번 중에서', style: TextStyle(fontSize: 18)),
                  ],
                ),
                SizedBox(
                  height: resultWidgetHeight * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('${probsProvider.gamesWon}',
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'SpoqaHanSansNeo',
                            fontWeight: FontWeight.w600)),
                    Text('번 승리했어요!', style: TextStyle(fontSize: 18)),
                  ],
                ),
              ]),
        ),
        SizedBox(
          width: resultWidgetWidth * 0.3,
          child: Column(children: [
            SizedBox(
              height: resultWidgetHeight * 0.2,
            ),
            Container(
              alignment: Alignment.center,
              height: resultWidgetHeight * 0.2,
              child: Text(
                '기대 승률',
                style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'SpoqaHanSansNeo',
                    fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(
              height: resultWidgetHeight * 0.05,
            ),
            Container(
                alignment: Alignment.center,
                height: resultWidgetHeight * 0.3,
                child: Text(
                  (probsProvider.games == 0)
                      ? '0%'
                      : '${(probsProvider.gamesWon / probsProvider.games * 100).toStringAsFixed(1).split('.')[1] == '0' ? (probsProvider.gamesWon / probsProvider.games * 100).toStringAsFixed(0) : (probsProvider.gamesWon / probsProvider.games * 100).toStringAsFixed(1)}%',
                  style: TextStyle(
                      fontSize: 28,
                      fontFamily: 'SpoqaHanSansNeo',
                      fontWeight: FontWeight.w400),
                )),
          ]),
        )
      ]),
    );
  }
}
