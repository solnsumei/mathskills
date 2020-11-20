import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mathskills/src/core/core.dart';

import 'package:mathskills/src/ui/widgets/numbers_list.dart';
import 'package:mathskills/src/ui/widgets/rounded_button.dart';
import 'package:provider/provider.dart';

GameProvider gameProvider;

Widget createNumbersListWidget() {
  gameProvider = GameProvider();
  gameProvider.selectNumber(4);
  gameProvider.acceptAnswer();
  gameProvider.selectNumber(3);

  return ChangeNotifierProvider<GameProvider>(
    create: (context) {
      return gameProvider;
    },
    child: MaterialApp(
      home: NumbersList(
        numList: gameProvider.numList,
        onItemPressed: gameProvider.selectNumber,
        selectedNumbers: gameProvider.selectedNumbers,
        usedNumbers: gameProvider.usedNumbers,
      ),
    ),
  );
}

void main() {
  group('NumbersList Widget Tests', () {
    testWidgets('Should show 9 RoundButtons', (tester) async {
      await tester.pumpWidget(createNumbersListWidget());
      expect(find.byType(Wrap), findsOneWidget);
      expect(find.byType(RoundedButton), findsNWidgets(9));
    });

    testWidgets('RoundedButton tap should trigger onItemClicked', (tester) async {
      await tester.pumpWidget(createNumbersListWidget());
      await tester.tap(find.byType(RoundedButton).first);
      await tester.pumpAndSettle();

      expect(gameProvider.selectedNumbers.length, 2);
    });
  });
}
