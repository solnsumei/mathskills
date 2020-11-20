import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:mathskills/src/core/core.dart';
import 'package:mathskills/src/ui/screens/result_page.dart';
import 'setup/mock_observer.dart';

NavigatorObserver mockObserver;
GameProvider gameProvider;

Widget createResultPage([MockNavigatorObserver observer]) => ChangeNotifierProvider<GameProvider>(
  create: (context) {
    gameProvider = GameProvider();
    return gameProvider;
  },
  child: MaterialApp(
    home: ResultPage(WINNING_TEXT),
    navigatorObservers: [observer],
  ),
);

void main() {
  group('Result Page Widget Tests', () {

    setUp(() {
      mockObserver = MockNavigatorObserver();
    });

    testWidgets('Should show one Column and RaisedButton', (tester) async {
      await tester.pumpWidget(createResultPage(mockObserver));
      expect(find.byType(Column), findsOneWidget);
      expect(find.byType(RaisedButton), findsOneWidget);
    });

    testWidgets('When tapping RaisedButton should pop widget', (tester) async {
      await tester.pumpWidget(createResultPage(mockObserver));
      await tester.tap(find.byType(RaisedButton).first);
      await tester.pumpAndSettle();
      verify(mockObserver.didPop(any, any));
    });
  });
}