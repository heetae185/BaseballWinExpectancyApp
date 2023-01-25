import 'package:baseball_win_expectancy/providers/probs_sqlite.dart';
import 'package:baseball_win_expectancy/models/probs.dart';

class SqliteHelper {
  Future<Probs> getProb(
      int homeAway, int inning, int outCount, int situation, int margin) async {
    var db = await ProbsSqlite.instance.database;
    List<Map> map = await db.rawQuery(
        'SELECT * FROM probs WHERE homeAway = ? AND inning = ? AND outCount = ? AND situation = ? AND margin = ?',
        [homeAway, inning, outCount, situation, margin]);
    return Probs.fromMap(map[0]);
  }
}
