import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:mockito/mockito.dart';
import 'package:mathskills/src/core/core.dart';
import 'package:mathskills/src/ui/screens/game_page.dart';
import 'package:mathskills/src/ui/screens/help_page.dart';
import 'package:mathskills/src/ui/screens/about_page.dart';
import 'package:mathskills/src/ui/widgets/widgets.dart';
import 'setup/mock_observer.dart';

NavigatorObserver mockObserver;
GameProvider gameProvider;

Widget createGameScreen([MockNavigatorObserver observer]) => ChangeNotifierProvider<GameProvider>(
  create: (context) {
    gameProvider = GameProvider();
    return gameProvider;
  },
  child: MaterialApp(
    navigatorObservers: [observer],
    initialRoute: "/",
    routes: {
      "/": (_) => GamePage(),
      "/help": (_) => HelpPage(),
      "/about": (_) => AboutPage(),
    },
  ),
);

void main() {
  group('Game Page Widget Tests', () {
    setUp(() {
      mockObserver = MockNavigatorObserver();
    });

    testWidgets('Testing Elements Visibility', (tester) async {
      await tester.pumpWidget(createGameScreen(mockObserver));
      expect(find.byType(Expanded), findsWidgets);
      expect(find.byType(SelectedItems), findsOneWidget);
      expect(find.byType(NumbersList), findsOneWidget);
      expect(find.byType(Wrap), findsWidgets);
      expect(find.byType(ActionChip), findsOneWidget);
    });

    testWidgets('Testing Redraw Action Chip', (tester) async {
      await tester.pumpWidget(createGameScreen(mockObserver));
      await tester.tap(find.byType(ActionChip).first);
      await tester.pumpAndSettle();

      expect(find.descendant(
          of: find.widgetWithText(ActionChip, '4'), matching: find.text('4')
      ), findsOneWidget);
    });

    testWidgets('How to play icon button should navigate to help screen', (tester) async {
      await tester.pumpWidget(createGameScreen(mockObserver));
      await tester.tap(find.byType(OutlineButton).first);
      await tester.pumpAndSettle();

      verify(mockObserver.didPush(captureAny, any));
    });

    testWidgets('About icon button should navigate to about screen', (tester) async {
      await tester.pumpWidget(createGameScreen(mockObserver));
      await tester.tap(find.byType(IconButton).first);
      await tester.pumpAndSettle();

      verify(mockObserver.didPush(captureAny, any));
    });
  });
}