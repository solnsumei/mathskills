import 'dart:math';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';

import '../utils/constants.dart';
import '../utils/helpers.dart';

class GameProvider with ChangeNotifier {
  final List<int> numList = List<int>.generate(9, (index) => index + 1);

  final List<IconData> _iconsList = [
    Icons.school,
    Icons.accessible_sharp,
    Icons.add_alert_outlined,
    Icons.wine_bar_outlined,
    Icons.bedtime_outlined,
    Icons.beach_access,
  ];

  final _box = Hive.box(SCORES_BOX);
  Set<int> _selectedNumbers = {};
  Set<int> _usedNumbers = {};
  int _redraws = NO_OF_REDRAWS;
  int _randomStars;
  bool _isAnswerCorrect;
  int _randomIconNum;
  int _counter = 60;
  Timer gameTimer;
  bool isGameOn = false;
  bool isGamePaused = false;

  Set<int> get selectedNumbers => _selectedNumbers;
  Set<int> get usedNumbers => _usedNumbers;
  int get redraws => _redraws;
  int get randomStars => _randomStars;
  bool get isAnswerCorrect => _isAnswerCorrect;
  IconData get getIconData => _iconsList[_randomIconNum];
  int get counter => _counter;
  Map<String, dynamic> get scores {
    return fetchScores();
  }

  GameProvider() {
    _randomStars = getRandomStars();
  }

  void resetCounter() {
    _counter = 60;
  }

  Map<String, dynamic> fetchScores() {
    return {
      BEST_TIME: _box.get(BEST_TIME),
      WINS: _box.get(WINS, defaultValue: 0),
      GAMES_PLAYED: _box.get(GAMES_PLAYED, defaultValue: 0)
    };
  }

  void saveScores (Map<String, dynamic> score) {
    _box.putAll(score);
  }

  Timer setTimer(int counter) {
    return Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (_counter > 0) {
        _counter--;
        notifyListeners();
      } else {
        isGameOn = false;
        notifyListeners();
        timer.cancel();
      }
    });
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
        .difference(_usedNumbers)).toList();

    return hasPossibleCombinations(possibleNumbers, _randomStars);
  }

  String checkGameStatus() {
    if (!isGameOn) {
      return null;
    }

    if (usedNumbers.length == 9) {
      stopCountdown();
      isGameOn = false;

      final score = {
        WINS: scores[WINS] + 1,
        GAMES_PLAYED: scores[GAMES_PLAYED] + 1,
      };

      int bestTime = scores[BEST_TIME] ?? 60;
      int timePlayed = 60 - _counter;

      if (timePlayed < bestTime) {
        score[BEST_TIME] = timePlayed;
      }

      saveScores(score);

      return WINNING_TEXT;
    }

    if (_counter == 0 || (_redraws == 0 && !possibleSolutions())) {
      isGameOn = false;
      stopCountdown();

      final score = {
        GAMES_PLAYED: scores[GAMES_PLAYED] + 1,
      };

      saveScores(score);

      return GAME_OVER_TEXT;
    }

    return null;
  }

  void pauseGame() {
    stopCountdown();
    isGamePaused = true;

    notifyListeners();
  }

  void resumeGame() {
    startCountdown();
    isGamePaused = false;

    notifyListeners();
  }

  void stopCountdown() {
    if (gameTimer != null) {
      gameTimer.cancel();
    }
  }

  void startCountdown() {
    if (gameTimer != null) {
      gameTimer.cancel();
    }

    gameTimer = setTimer(_counter);
  }

  void startGame() {
    _usedNumbers.clear();
    _redraws = NO_OF_REDRAWS;
    resetCounter();
    reload();
    startCountdown();
    isGameOn = true;
    isGamePaused = false;

    notifyListeners();
  }

  static of(BuildContext context, {bool listen: true}) {
    return Provider.of<GameProvider>(context, listen: listen);
  }
}