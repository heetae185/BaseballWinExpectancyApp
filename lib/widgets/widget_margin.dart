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
    double marginWidgetHeight = MediaQuery.of(context).size.height * 0.15;
    double marginWidgetWidth = MediaQuery.of(context).size.width * 0.5;
    double marginButtonWidth = MediaQuery.of(context).size.width * 0.5 * 0.8;

    return Column(children: [
      SizedBox(
        height: marginWidgetHeight * 0.2,
      ),
      SizedBox(
        height: marginWidgetHeight * 0.2,
        child: const Text(
          '점수 차이',
          style: TextStyle(fontSize: 22),
        ),
      ),
      SizedBox(
        height: marginWidgetHeight * 0.1,
      ),
      SizedBox(
        height: marginWidgetHeight * 0.35,
        child: Row(children: [
          SizedBox(
            width: marginWidgetWidth * 0.1,
          ),
          Container(
            alignment: Alignment.center,
            width: marginButtonWidth,
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xFF424242)),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(children: [
              SizedBox(
                width: (marginButtonWidth - 2) * 0.3,
                height: marginWidgetHeight * 0.35,
                child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Color(0xFFEBEBEB)),
                    ),
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
                      probsProvider.setResults(newProb.games, newProb.gamesWon,
                          newProb.winExpectancy);
                    },
                    child: const Text(
                      '-',
                      style: TextStyle(color: Colors.black, fontSize: 24),
                    )),
              ),
              Container(
                alignment: Alignment.center,
                width: (marginButtonWidth - 2) * 0.4,
                height: marginWidgetHeight * 0.35,
                child: Text(
                  "${margin > 0 ? "+" : ""}$margin",
                  style: const TextStyle(fontSize: 20),
                ),
              ),
              SizedBox(
                width: (marginButtonWidth - 2) * 0.3,
                height: marginWidgetHeight * 0.35,
                child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(const Color(0xFFEBEBEB)),
                    ),
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
                      probsProvider.setResults(newProb.games, newProb.gamesWon,
                          newProb.winExpectancy);
                    },
                    child: const Text(
                      '+',
                      style: TextStyle(color: Colors.black, fontSize: 24),
                    )),
              ),
            ]),
          ),
          SizedBox(
            width: marginWidgetWidth * 0.1,
          ),
        ]),
      ),
      SizedBox(
        height: marginWidgetHeight * 0.15,
      )
    ]);
  }
}
