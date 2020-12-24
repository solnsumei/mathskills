import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/constants.dart';
import '../utils/helpers.dart';

class GameProvider with ChangeNotifier {
  final List<int> numList = List<int>.generate(9, (index) => index + 1);

  final List<IconData> _iconsList = [
    Icons.school,
    Icons.agriculture,
    Icons.phone_android,
    Icons.add_alert_outlined,
    Icons.wine_bar_outlined,
    Icons.bedtime_outlined,
    Icons.beach_access,
    Icons.add_a_photo,
  ];

  List<int> _selectedNumbers = [];
  List<int> _usedNumbers = [];
  int _redraws = NO_OF_REDRAWS;
  int _randomStars;
  bool _isAnswerCorrect;
  int _randomIconNum;

  List<int> get selectedNumbers => _selectedNumbers;
  List<int> get usedNumbers => _usedNumbers;
  int get redraws => _redraws;
  int get randomStars => _randomStars;
  bool get isAnswerCorrect => _isAnswerCorrect;
  IconData get getIconData => _iconsList[_randomIconNum];

  GameProvider() {
    _randomStars = getRandomStars();
  }

  void selectNumber(int num) {
    if (_selectedNumbers.contains(num) || _usedNumbers.contains(num)) return;

    _selectedNumbers.add(num);
    _isAnswerCorrect = null;

    notifyListeners();
  }

  void removeSelectedNumber(int num) {
    if (_selectedNumbers.contains(num)) {
      _selectedNumbers.remove(num);
      _isAnswerCorrect = null;

      notifyListeners();
    }
  }

  int getRandomStars() {
    _randomIconNum = Random().nextInt(_iconsList.length);
    return Random().nextInt(9) + 1;
  }

  void reload() {
    _selectedNumbers.clear();
    _randomStars = getRandomStars();
    _isAnswerCorrect = null;
  }

  void checkAnswer() {
    _isAnswerCorrect = _randomStars == _selectedNumbers
        .reduce((value, element) => value + element);

    notifyListeners();
  }

  String acceptAnswer() {
    _usedNumbers.addAll(_selectedNumbers);
    reload();

    notifyListeners();
    return checkGameStatus();
  }

  void redraw() {
    if (_redraws == 0) return;

    _redraws -= 1;
    reload();

    notifyListeners();
  }

  bool possibleSolutions() {
    final List<int> possibleNumbers = (numList.toSet()
        .difference(_usedNumbers.toSet())).toList();

    return hasPossibleCombinations(possibleNumbers, _randomStars);
  }

  String checkGameStatus() {
    if (usedNumbers.length == 9) {
      return WINNING_TEXT;
    }

    if (_redraws == 0 && !possibleSolutions()) {
      return GAME_OVER_TEXT;
    }

    return null;
  }

  void restart() {
    _usedNumbers.clear();
    _redraws = NO_OF_REDRAWS;
    reload();

    notifyListeners();
  }

  static of(BuildContext context, {bool listen: true}) {
    return Provider.of<GameProvider>(context, listen: listen);
  }
}