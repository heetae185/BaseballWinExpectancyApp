import 'package:baseball_win_expectancy/providers/sqlite_helper.dart';
import 'package:flutter/material.dart';
import 'package:baseball_win_expectancy/models/probs.dart';
import 'package:provider/provider.dart';

class HomeAwayWidget extends StatefulWidget {
  @override
  _HomeAwayWidgetState createState() => _HomeAwayWidgetState();
}

double xAlign = -0.9;
const double homeAlign = -0.95;
const double awayAlign = 0.95;
const Color selectedColor = Color(0xFF9CC06F);
const Color normalColor = Color(0xFFF5F5F5);

class _HomeAwayWidgetState extends State<HomeAwayWidget> {
  // if home team then homeAway == 0, else if away team then homeAway == 1
  int homeAway = 0;
  late List<bool> isSelected;
  SqliteHelper sqliteHelper = SqliteHelper();

  Color homeColor = selectedColor;
  Color awayColor = normalColor;

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

    double toggleButtonWidth = MediaQuery.of(context).size.width * 0.8;
    double toggleButtonHeight = MediaQuery.of(context).size.height * 0.042;
    double toggleButtonMarginWidth = MediaQuery.of(context).size.width * 0.05;
    double toggleButtonMarginHeight =
        MediaQuery.of(context).size.height * 0.008;
    double toggleButtonSizedBoxHeight =
        MediaQuery.of(context).size.height * 0.005;

    return Container(
      color: Colors.white,
      margin: EdgeInsets.fromLTRB(
          toggleButtonMarginWidth, 0, toggleButtonMarginWidth, 0),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text(
          '우리팀은',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(
          height: toggleButtonSizedBoxHeight,
        ),
        Container(
            width: toggleButtonWidth,
            height: toggleButtonHeight,
            decoration: const BoxDecoration(
              color: Color(0xFFF5F5F5),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Stack(
              children: [
                AnimatedAlign(
                    alignment: Alignment(xAlign, -(0.1 * 0.042 * 0.15)),
                    duration: const Duration(milliseconds: 100),
                    child: Container(
                      width: toggleButtonWidth * 0.5 * 0.95,
                      height: toggleButtonHeight * 0.8,
                      decoration: const BoxDecoration(
                          color: Color(0xFF9CC06F),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    )),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      xAlign = homeAlign;
                      homeColor = selectedColor;
                      awayColor = normalColor;
                    });
                  },
                  child: Align(
                    alignment: Alignment(-1, 0),
                    child: Container(
                      width: toggleButtonWidth * 0.5,
                      color: Colors.transparent,
                      alignment: Alignment.center,
                      child: Text(
                        '홈팀',
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'SpoqaHanSansNeo',
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      xAlign = awayAlign;
                      homeColor = selectedColor;
                      awayColor = normalColor;
                    });
                  },
                  child: Align(
                    alignment: Alignment(1, 0),
                    child: Container(
                      width: toggleButtonWidth * 0.5,
                      color: Colors.transparent,
                      alignment: Alignment.center,
                      child: Text(
                        '원정팀',
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'SpoqaHanSansNeo',
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                )
              ],
            )),
      ]),
    );
  }
}
