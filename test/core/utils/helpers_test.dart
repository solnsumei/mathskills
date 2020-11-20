import 'package:test/test.dart';
import 'package:mathskills/src/core/utils/helpers.dart';

void main() {
  group('App Provider Tests', () {
    test('Has Possible Combinations returns true', () {
      final int number = 9;
      final itemsList = [1, 3, 5];

      expect(hasPossibleCombinations(itemsList, number), true);
    });

    test('Has Possible Combinations recursion returns true', () {
      final int number = 4;
      final itemsList = [1, 3, 5];

      expect(hasPossibleCombinations(itemsList, number), true);
    });

    test('Has Possible Combinations returns false', () {
      final int number = 9;
      final itemsList = [2, 3, 8];

      expect(hasPossibleCombinations(itemsList, number), false);
    });
  });
}
