import 'package:flutter_test/flutter_test.dart';
import 'package:tictactoe/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('App starts with an empty board', (WidgetTester tester) async {
    await tester.pumpWidget(ChangeNotifierProvider(
      create: (context) => TicTacToeModel(),
      child: const MyApp(),
    ));

    // Verify that the board starts empty.
    expect(find.text('X'), findsNothing);
    expect(find.text('O'), findsNothing);
  });

  testWidgets('Tapping a tile changes it to "X"', (WidgetTester tester) async {
    await tester.pumpWidget(ChangeNotifierProvider(
      create: (context) => TicTacToeModel(),
      child: const MyApp(),
    ));

    // Tap the first tile.
    await tester.tap(find.byType(GestureDetector).first);
    await tester.pump();

    // Verify that the first tile is now "X".
    expect(find.text('X'), findsOneWidget);
  });

  testWidgets('Tapping a tile twice doesn\'t change it to "O"',
      (WidgetTester tester) async {
    await tester.pumpWidget(ChangeNotifierProvider(
      create: (context) => TicTacToeModel(),
      child: const MyApp(),
    ));

    // Tap the first tile twice.
    await tester.tap(find.byType(GestureDetector).first);
    await tester.pump();
    await tester.tap(find.byType(GestureDetector).first);
    await tester.pump();

    // Verify that the first tile is still "X".
    expect(find.text('X'), findsOneWidget);
    expect(find.text('O'), findsNothing);
  });

  testWidgets('Tapping a different tile after the first one changes it to "O"',
      (WidgetTester tester) async {
    await tester.pumpWidget(ChangeNotifierProvider(
      create: (context) => TicTacToeModel(),
      child: const MyApp(),
    ));

    // Tap the first tile, then the second one.
    await tester.tap(find.byType(GestureDetector).at(0));
    await tester.pump();
    await tester.tap(find.byType(GestureDetector).at(1));
    await tester.pump();

    // Verify that the first tile is "X" and the second one is "O".
    expect(find.text('X'), findsOneWidget);
    expect(find.text('O'), findsOneWidget);
  });

  testWidgets('A win resets the board', (WidgetTester tester) async {
    await tester.pumpWidget(ChangeNotifierProvider(
      create: (context) => TicTacToeModel(),
      child: const MyApp(),
    ));

    // Tap the first row for X.
    await tester.tap(find.byType(GestureDetector).at(0));
    await tester.pump();
    await tester.tap(find.byType(GestureDetector).at(3));
    await tester.pump();
    await tester.tap(find.byType(GestureDetector).at(1));
    await tester.pump();
    await tester.tap(find.byType(GestureDetector).at(4));
    await tester.pump();
    await tester.tap(find.byType(GestureDetector).at(2));
    await tester.pump();

    // Verify that the board is empty.
    expect(find.text('X'), findsNothing);
    expect(find.text('O'), findsNothing);
  });
}
