import 'package:flutter/cupertino.dart';

class Base extends ChangeNotifier {
  late bool firstBase;
  late bool secondBase;
  late bool thirdBase;

  Base(
      {required this.firstBase,
      required this.secondBase,
      required this.thirdBase});

  Map<String, dynamic> toMap() {
    return {
      'firstBase': firstBase,
      'secondBase': secondBase,
      'thirdBase': thirdBase
    };
  }

  Base.fromMap(Map<dynamic, dynamic>? map) {
    firstBase = map?['firstBase'];
    secondBase = map?['secondBase'];
    thirdBase = map?['thirdBase'];
  }

  void switchFirstBase() {
    firstBase = !firstBase;
    notifyListeners();
  }

  void switchSecondBase() {
    secondBase = !secondBase;
    notifyListeners();
  }

  void switchThirdBase() {
    thirdBase = !thirdBase;
    notifyListeners();
  }

  int toSituationCode() {
    int situationCode = 0;
    if (firstBase == false && secondBase == false && thirdBase == false) {
      situationCode = 1;
    } else if (firstBase == true && secondBase == false && thirdBase == false) {
      situationCode = 2;
    } else if (firstBase == false && secondBase == true && thirdBase == false) {
      situationCode = 3;
    } else if (firstBase == true && secondBase == true && thirdBase == false) {
      situationCode = 4;
    } else if (firstBase == false && secondBase == false && thirdBase == true) {
      situationCode = 5;
    } else if (firstBase == true && secondBase == false && thirdBase == true) {
      situationCode = 6;
    } else if (firstBase == false && secondBase == true && thirdBase == true) {
      situationCode = 6;
    } else if (firstBase == true && secondBase == true && thirdBase == true) {
      situationCode = 7;
    }
    return situationCode;
  }
}
