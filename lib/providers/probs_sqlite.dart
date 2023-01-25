import 'package:baseball_win_expectancy/models/probs.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';

class ProbsSqlite {
  static final ProbsSqlite _db = new ProbsSqlite._internal();
  ProbsSqlite._internal();
  static ProbsSqlite get instance => _db;
  static Database? _database;

  Future<Database> get database async => _database ??= await _initDb();

  Future<Database> _initDb() async {
    var dbDir = await getDatabasesPath();
    var dbPath = join(dbDir, 'probs.db');

    // Delete any existing database:
    await deleteDatabase(dbPath);
    // Create the writable database file from the bundled demo database file:
    ByteData data = await rootBundle.load("assets/database/probs.db");

    List<int> bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    await File(dbPath).writeAsBytes(bytes);

    return await openDatabase(dbPath);
  }

  // late Database db;

  // Future initDb() async {
  //   var dbDir = await getDatabasesPath();
  //   var dbPath = join(dbDir, 'probs.db');

  //   // Delete any existing database:
  //   await deleteDatabase(dbPath);
  //   // Create the writable database file from the bundled demo database file:
  //   ByteData data = await rootBundle.load("assets/database/probs.db");
  //   List<int> bytes =
  //       data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  //   await File(dbPath).writeAsBytes(bytes);

  //   db = await openDatabase(dbPath);
  // }

  // Future<List<Probs>> getProbs() async {
  //   var db = await ProbsSqlite.instance.database;
  //   List<Probs> probs = [];
  //   List<Map> maps = await db.rawQuery('SELECT * FROM probs');
  //   maps.forEach((map) {
  //     probs.add(Probs.fromMap(map));
  //   });
  //   return probs;
  // }

  // Future<Probs> getProb(
  //     int homeAway, int inning, int outCount, int situation, int margin) async {
  //   var db = await ProbsSqlite.instance.database;
  //   List<Map> map = await db.rawQuery(
  //       'SELECT * FROM probs WHERE homeAway = ? AND inning = ? AND outCount = ? AND situation = ? AND margin = ?',
  //       [homeAway, inning, outCount, situation, margin]);
  //   return Probs.fromMap(map[0]);
  // }
}
