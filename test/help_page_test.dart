import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:mathskills/src/core/core.dart';
import 'package:mathskills/src/ui/screens/help_page.dart';
import 'setup/mock_observer.dart';

NavigatorObserver mockObserver;
GameProvider gameProvider;

Widget createHelpPage([MockNavigatorObserver observer]) => ChangeNotifierProvider<GameProvider>(
  create: (context) => GameProvider(),
  child: MaterialApp(
    home: HelpPage(),
    navigatorObservers: [observer],
  ),
);

void main() {
  group('Help Page Widget Tests', () {

    setUp(() {
      mockObserver = MockNavigatorObserver();
    });

    testWidgets('Should show one ListView', (tester) async {
      await tester.pumpWidget(createHelpPage(mockObserver));
      expect(find.byType(ListView), findsOneWidget);
      expect(find.text('Step 1'), findsOneWidget);
    });

    testWidgets('When tapping RaisedButton should pop widget', (tester) async {
      await tester.pumpWidget(createHelpPage(mockObserver));
      await tester.tap(find.byType(IconButton).first);
      await tester.pumpAndSettle();
      verify(mockObserver.didPop(any, any));
    });
  });
}