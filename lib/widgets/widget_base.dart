import 'package:baseball_win_expectancy/providers/sqlite_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;
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
    final base = Provider.of<Base>(context);
    final probsProvider = Provider.of<Probs>(context);
    late Probs newProb;
    double baseFrameHeight = MediaQuery.of(context).size.height * 0.25;
    double baseWidgetMargin = MediaQuery.of(context).size.width * 0.05;

    return Container(
        margin: EdgeInsets.fromLTRB(baseWidgetMargin, 0, baseWidgetMargin, 0),
        height: baseFrameHeight,
        decoration: BoxDecoration(
          color: const Color(0xFF9CC06F),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: baseFrameHeight * 0.4,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Transform.rotate(
                      angle: -45 * math.pi / 180,
                      child: Container(
                        width: baseFrameHeight * 0.275 * math.sqrt(2),
                        height: baseFrameHeight * 0.06,
                        decoration: BoxDecoration(color: Color(0xFFFFCD8E)),
                      ),
                    ),
                    Transform.rotate(
                      angle: 45 * math.pi / 180,
                      child: Container(
                        width: baseFrameHeight * 0.275 * math.sqrt(2),
                        height: baseFrameHeight * 0.06,
                        decoration: BoxDecoration(color: Color(0xFFFFCD8E)),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: baseFrameHeight * 0.3,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Transform.rotate(
                      angle: 45 * math.pi / 180,
                      child: Container(
                        width: baseFrameHeight * 0.275 * math.sqrt(2),
                        height: baseFrameHeight * 0.06,
                        decoration: BoxDecoration(color: Color(0xFFFFCD8E)),
                      ),
                    ),
                    Transform.rotate(
                      angle: -45 * math.pi / 180,
                      child: Container(
                        width: baseFrameHeight * 0.275 * math.sqrt(2),
                        height: baseFrameHeight * 0.06,
                        decoration: BoxDecoration(color: Color(0xFFFFCD8E)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: RightTriangleShape(
                  width: baseFrameHeight * 0.1 * math.sqrt(2),
                  height: baseFrameHeight * 0.1 * math.sqrt(2),
                  color: Colors.white),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: baseFrameHeight * 0.15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Transform.rotate(
                        angle: 45 * math.pi / 180,
                        child: Stack(
                          children: [
                            Container(
                              width: baseFrameHeight * 0.2,
                              height: baseFrameHeight * 0.2,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.7),
                                      blurRadius: 3.0,
                                      spreadRadius: 0.0,
                                      offset: const Offset(0, 3),
                                    )
                                  ]),
                            ),
                            Container(
                              margin: EdgeInsets.all(baseFrameHeight * 0.02),
                              width: baseFrameHeight * 0.16,
                              height: baseFrameHeight * 0.16,
                              child: TextButton(
                                onPressed: () async {
                                  setState(() {
                                    secondBase = !secondBase;
                                  });
                                  base.switchSecondBase();
                                  probsProvider
                                      .changeSituation(base.toSituationCode());
                                  newProb = await getProb(
                                      probsProvider.homeAway,
                                      probsProvider.topBottom,
                                      probsProvider.inning,
                                      probsProvider.outCount,
                                      probsProvider.situation,
                                      probsProvider.margin);
                                  probsProvider.setResults(newProb.games,
                                      newProb.gamesWon, newProb.winExpectancy);
                                },
                                style: secondBase
                                    ? ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                const Color(0xFF9CC06F)),
                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(3))))
                                    : ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.white)),
                                child: const Text(''),
                              ),
                            )
                          ],
                        ))
                  ],
                ),
                SizedBox(
                  height: baseFrameHeight * (0.55 * 0.5 - 0.1),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Transform.rotate(
                        angle: 45 * math.pi / 180,
                        child: Stack(
                          children: [
                            Container(
                              width: baseFrameHeight * 0.2,
                              height: baseFrameHeight * 0.2,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.7),
                                      blurRadius: 3.0,
                                      spreadRadius: 0.0,
                                      offset: const Offset(0, 3),
                                    )
                                  ]),
                            ),
                            Container(
                              margin: EdgeInsets.all(baseFrameHeight * 0.02),
                              width: baseFrameHeight * 0.16,
                              height: baseFrameHeight * 0.16,
                              child: TextButton(
                                onPressed: () async {
                                  setState(() {
                                    thirdBase = !thirdBase;
                                  });
                                  base.switchThirdBase();
                                  probsProvider
                                      .changeSituation(base.toSituationCode());
                                  newProb = await getProb(
                                      probsProvider.homeAway,
                                      probsProvider.topBottom,
                                      probsProvider.inning,
                                      probsProvider.outCount,
                                      probsProvider.situation,
                                      probsProvider.margin);
                                  probsProvider.setResults(newProb.games,
                                      newProb.gamesWon, newProb.winExpectancy);
                                },
                                style: thirdBase
                                    ? ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                const Color(0xFF9CC06F)),
                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(3))))
                                    : ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.white)),
                                child: const Text(''),
                              ),
                            )
                          ],
                        )),
                    SizedBox(width: baseFrameHeight * 0.55),
                    Transform.rotate(
                        angle: 45 * math.pi / 180,
                        child: Stack(
                          children: [
                            Container(
                              width: baseFrameHeight * 0.2,
                              height: baseFrameHeight * 0.2,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.7),
                                      blurRadius: 3.0,
                                      spreadRadius: 0.0,
                                      offset: const Offset(0, 3),
                                    )
                                  ]),
                            ),
                            Container(
                              margin: EdgeInsets.all(baseFrameHeight * 0.02),
                              width: baseFrameHeight * 0.16,
                              height: baseFrameHeight * 0.16,
                              child: TextButton(
                                onPressed: () async {
                                  setState(() {
                                    firstBase = !firstBase;
                                  });
                                  base.switchFirstBase();
                                  probsProvider
                                      .changeSituation(base.toSituationCode());
                                  newProb = await getProb(
                                      probsProvider.homeAway,
                                      probsProvider.topBottom,
                                      probsProvider.inning,
                                      probsProvider.outCount,
                                      probsProvider.situation,
                                      probsProvider.margin);
                                  probsProvider.setResults(newProb.games,
                                      newProb.gamesWon, newProb.winExpectancy);
                                },
                                style: firstBase
                                    ? ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                const Color(0xFF9CC06F)),
                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(3))))
                                    : ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.white)),
                                child: const Text(''),
                              ),
                            )
                          ],
                        )),
                  ],
                ),
              ],
            ),
          ],
        ));
  }
}

class RightTriangleShape extends StatelessWidget {
  final double width;
  final double height;
  final Color color;

  RightTriangleShape({
    required this.width,
    required this.height,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: CustomPaint(
        painter: _RightTrianglePainter(color),
      ),
    );
  }
}

class _RightTrianglePainter extends CustomPainter {
  final Color color;

  _RightTrianglePainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..color = color;
    final path = Path()
      ..moveTo(size.width * 0.5, 0)
      ..lineTo(size.width * 1.5, size.height * 0.8)
      ..lineTo(size.width * 1.5, size.height)
      ..lineTo(-size.width * 0.5, size.height)
      ..lineTo(-size.width * 0.5, size.height * 0.8)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_RightTrianglePainter oldDelegate) => false;
}
