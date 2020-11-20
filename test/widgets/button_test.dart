import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mathskills/src/core/core.dart';

import 'package:mathskills/src/ui/widgets/button.dart';
import 'package:provider/provider.dart';


void checkGameStatus(BuildContext context, GameProvider provider) {
  provider.checkGameStatus();
}

Widget createButton(GameProvider gameProvider) {
  return ChangeNotifierProvider<GameProvider>(
    create: (context) {
      return gameProvider;
    },
    child: MaterialApp(
      home: Button(checkGameStatus),
    ),
  );
}

void main() {
  group('Button Widget Tests', () {
    testWidgets('Should show Row and RawMaterialButton', (tester) async {
      final gameProvider = GameProvider();
      gameProvider.selectNumber(6);
      await tester.pumpWidget(createButton(gameProvider));
      expect(find.byType(Row), findsOneWidget);
      expect(find.byType(RawMaterialButton), findsOneWidget);
    });

    testWidgets('Should show close icon button when answer is wrong', (tester) async {
      final gameProvider = GameProvider();
      final numberToAdd = gameProvider.randomStars == 1
          ? gameProvider.randomStars + 1 : gameProvider.randomStars - 1;

      gameProvider.selectNumber(numberToAdd);
      gameProvider.checkAnswer();

      await tester.pumpWidget(createButton(gameProvider));
      expect(find.byIcon(Icons.close_rounded), findsOneWidget);
    });

    testWidgets('Should trigger checkAndSelectAnswer when button is tapped', (tester) async {
      final gameProvider = GameProvider();

      gameProvider.selectNumber(gameProvider.randomStars);

      await tester.pumpWidget(createButton(gameProvider));
      await tester.tap(find.byType(RawMaterialButton).first);
      await tester.pumpAndSettle();

      expect(gameProvider.selectedNumbers.length, greaterThan(0));
      gameProvider.checkAnswer();
      await tester.tap(find.byType(RawMaterialButton).first);
      await tester.pumpAndSettle();

      expect(gameProvider.selectedNumbers.length, 0);
      expect(gameProvider.usedNumbers.length, greaterThanOrEqualTo(1));
    });
  });
}
