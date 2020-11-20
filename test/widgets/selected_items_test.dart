import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mathskills/src/core/core.dart';

import 'package:mathskills/src/ui/widgets/selected_items.dart';
import 'package:mathskills/src/ui/widgets/rounded_button.dart';
import 'package:provider/provider.dart';

GameProvider gameProvider = GameProvider();

Widget createSelectedItemsWidget() {
  return ChangeNotifierProvider<GameProvider>(
    create: (context) {
      return gameProvider;
    },
    child: MaterialApp(
      home: SelectedItems(
        onItemClicked: gameProvider.removeSelectedNumber,
        selectedItems: gameProvider.selectedNumbers,
      ),
    ),
  );
}

void main() {
  group('SelectedItems Widget Tests', () {
    testWidgets('Should show no RoundedButtons when selectedItems list is empty', (tester) async {
      await tester.pumpWidget(createSelectedItemsWidget());
      expect(find.byType(Wrap), findsOneWidget);
      expect(find.byType(RoundedButton), findsNothing);
    });

    testWidgets('Should show one RoundedButton', (tester) async {
      gameProvider.selectNumber(5);
      await tester.pumpWidget(createSelectedItemsWidget());
      expect(find.byType(RoundedButton), findsOneWidget);
    });

    testWidgets('Should show one RoundedButton', (tester) async {
      await tester.pumpWidget(createSelectedItemsWidget());
      await tester.tap(find.byType(RoundedButton).first);
      await tester.pumpAndSettle();

      expect(gameProvider.selectedNumbers.length, 0);
    });
  });
}
