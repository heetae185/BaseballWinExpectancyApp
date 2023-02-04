import 'package:flutter/cupertino.dart';

class Probs extends ChangeNotifier {
  late int homeAway;
  late int topBottom;
  late int inning;
  late int outCount;
  late int situation;
  late int margin;
  late int games;
  late int gamesWon;
  late double winExpectancy;

  Probs({
    required this.homeAway,
    required this.topBottom,
    required this.inning,
    required this.outCount,
    required this.situation,
    required this.margin,
    required this.games,
    required this.gamesWon,
    required this.winExpectancy,
  });

  Map<String, dynamic> toMap() {
    return {
      'homeAway': homeAway,
      'topBottom': topBottom,
      'inning': inning,
      'outCount': outCount,
      'situation': situation,
      'margin': margin,
      'games': games,
      'gamesWon': gamesWon,
      'winExpectancy': winExpectancy
    };
  }

  Probs.fromMap(Map<dynamic, dynamic>? map) {
    homeAway = map?['homeAway'];
    topBottom = map?['topBottom'];
    inning = map?['inning'];
    outCount = map?['outCount'];
    situation = map?['situation'];
    margin = map?['margin'];
    games = map?['games'];
    gamesWon = map?['gamesWon'];
    winExpectancy = map?['winExpectancy'];
  }

  void changeHomeAway(int newHomeAway) {
    homeAway = newHomeAway;
    notifyListeners();
  }

  void changeSituation(int newSituation) {
    situation = newSituation;
    notifyListeners();
  }

  void changeOutCount(int newOutCount) {
    outCount = newOutCount;
    notifyListeners();
  }

  void setResults(int newGames, int newGamesWon, double newWinExpectancy) {
    games = newGames;
    gamesWon = newGamesWon;
    winExpectancy = newWinExpectancy;
  }
}
