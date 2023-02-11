import 'package:baseball_win_expectancy/providers/probs_sqlite.dart';
import 'package:baseball_win_expectancy/models/probs.dart';

class SqliteHelper {
  Future<Probs> getProb(int homeAway, int topBottom, int inning, int outCount,
      int situation, int margin) async {
    var db = await ProbsSqlite.instance.database;
    List<Map> map = await db.rawQuery(
        'SELECT * FROM probs WHERE homeAway = ? AND topBottom = ? AND inning = ? AND outCount = ? AND situation = ? AND margin = ?',
        [homeAway, topBottom, inning, outCount, situation, margin]);
    try {
      return Probs.fromMap(map[0]);
    } on TypeError {
      return Probs(
          homeAway: 0,
          topBottom: 0,
          inning: 0,
          outCount: 0,
          situation: 0,
          margin: 0,
          games: 0,
          gamesWon: 0,
          winExpectancy: 0);
    }
  }
}
