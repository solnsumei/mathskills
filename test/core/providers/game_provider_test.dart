import 'package:test/test.dart';
import 'package:mathskills/src/core/providers/game_provider.dart';

void main() {
  group('Game Provider Tests', () {
    final gameProvider = GameProvider();

    test('Ensure Game provider should be default', () {
      expect(gameProvider.randomStars, greaterThanOrEqualTo(1));
      expect(gameProvider.randomStars, lessThanOrEqualTo(9));
      expect(gameProvider.selectedNumbers.length, equals(0));
      expect(gameProvider.usedNumbers.length, equals(0));
      expect(gameProvider.numList.length, equals(9));
      expect(gameProvider.isAnswerCorrect, null);
      expect(gameProvider.redraws, equals(5));
    });

    test('SelectNumber method should add number only once to selectedNumbers list', () {
      final number = 3;

      gameProvider.selectNumber(number);
      expect(gameProvider.selectedNumbers.contains(number), true);
      gameProvider.selectNumber(number);
      expect(gameProvider.selectedNumbers.contains(number), true);
    });

    test('Removed selected Number method should remove number from selectedNumbers list', () {
      final number = 3;

      gameProvider.selectNumber(number);

      expect(gameProvider.selectedNumbers.contains(number), true);
      gameProvider.removeSelectedNumber(number);
      expect(gameProvider.selectedNumbers.contains(number), false);
    });

    test('isAnswerCorrect should be false when check answer is called', () {
      final numberToAdd = gameProvider.randomStars == 1
          ? gameProvider.randomStars + 1 : gameProvider.randomStars - 1;

      gameProvider.selectNumber(numberToAdd);

      expect(gameProvider.selectedNumbers.contains(numberToAdd), true);
      gameProvider.checkAnswer();
      expect(gameProvider.isAnswerCorrect, false);
      gameProvider.restart();
    });

    test('isAnswerCorrect should be true when check answer is called', () {
      gameProvider.selectNumber(gameProvider.randomStars);
      gameProvider.checkAnswer();
      expect(gameProvider.isAnswerCorrect, true);
      gameProvider.restart();
    });

    test('acceptAnswer method should add selectedNumbers to usedNumbers list', () {
      gameProvider.selectNumber(gameProvider.randomStars);
      gameProvider.checkAnswer();
      gameProvider.acceptAnswer();
      expect(gameProvider.selectedNumbers.length, equals(0));
      expect(gameProvider.usedNumbers.length, greaterThanOrEqualTo(1));
      gameProvider.restart();
    });

    test('Redraw method should decrement number of redraws', () {
      expect(gameProvider.redraws, equals(5));
      gameProvider.redraw();
      expect(gameProvider.redraws, equals(4));
      gameProvider.restart();
    });

    test('Running possible solutions should return true', () {
      gameProvider.selectNumber(gameProvider.randomStars);
      expect(gameProvider.possibleSolutions(), true);
      gameProvider.restart();
    });
  });
}