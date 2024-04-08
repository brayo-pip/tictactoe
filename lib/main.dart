import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => TicTacToeModel(),
      child: const MyApp(),
    ),
  );
}

class TicTacToeModel extends ChangeNotifier {
  Map<Key, String?> squareTileStates = {};
  Map<Key, Color?> squareTileColors = {};
  var playersTurn = 'X';
  // ignore: non_constant_identifier_names
  var OWins = 0;
  // ignore: non_constant_identifier_names
  var XWins = 0;
  var turns = 0;
  var horizontalKeys = [
    [const Key('0'), const Key('1'), const Key('2')],
    [const Key('3'), const Key('4'), const Key('5')],
    [const Key('6'), const Key('7'), const Key('8')],
  ];
  var verticalKeys = [
    [const Key('0'), const Key('3'), const Key('6')],
    [const Key('1'), const Key('4'), const Key('7')],
    [const Key('2'), const Key('5'), const Key('8')],
  ];
  var diagonalKeys = [
    [const Key('0'), const Key('4'), const Key('8')],
    [const Key('2'), const Key('4'), const Key('6')],
  ];
  void resetTileState() {
    for (var i = 0; i < 9; i++) {
      squareTileStates[Key('$i')] = null;
    }
    playersTurn = 'X';
  }

  void resetTileColor() {
    for (var i = 0; i < 9; i++) {
      squareTileColors[Key('$i')] = Colors.purple;
    }
  }

  void updateSquareTileColors(Key key) {
    if (playersTurn == 'X') {
      squareTileColors[key] = Colors.amber;
      return;
    }
    squareTileColors[key] = Colors.lightBlue;
  }

  int horizontalIdx = 0;
  int verticalIdx = 0;
  int diagonalIdx = 4;
  int diagonalIdx2 = 4;

  void checkWin(Key key) {
    turns += 1;
    if (turns <= 4) {
      playersTurn = playersTurn == 'X' ? 'O' : 'X';
      return;
    }
    switch (key.toString()) {
      case "[<'0'>]":
        horizontalIdx = 0;
        verticalIdx = 0;
        diagonalIdx = 0;
        break;
      case "[<'1'>]":
        horizontalIdx = 0;
        verticalIdx = 1;
        break;
      case "[<'2'>]":
        horizontalIdx = 0;
        verticalIdx = 2;
        diagonalIdx = 1;
        break;
      case "[<'3'>]":
        horizontalIdx = 1;
        verticalIdx = 0;
        break;
      case "[<'4'>]":
        horizontalIdx = 1;
        verticalIdx = 1;
        diagonalIdx = 0;
        diagonalIdx2 = 1;
        break;
      case "[<'5'>]":
        horizontalIdx = 1;
        verticalIdx = 2;
        break;
      case "[<'6'>]":
        horizontalIdx = 2;
        verticalIdx = 0;
        diagonalIdx = 1;
        break;
      case "[<'7'>]":
        horizontalIdx = 2;
        verticalIdx = 1;
        break;
      case "[<'8'>]":
        horizontalIdx = 2;
        verticalIdx = 2;
        diagonalIdx = 0;
        break;

      default:
        break;
    }
    if (horizontalCheck(horizontalIdx)) {
      resetTileState();
      resetTileColor();
      turns = 0;
      return;
    } else if (verticalCheck(verticalIdx)) {
      resetTileState();
      resetTileColor();
      turns = 0;
      return;
    } else if (diagonalCheck(diagonalIdx)) {
      resetTileState();
      resetTileColor();
      turns = 0;
      return;
    } else if (diagonalCheck(diagonalIdx2)) {
      resetTileState();
      resetTileColor();
      turns = 0;
      return;
    } else if (turns == 9) {
      resetTileState();
      resetTileColor();
      turns = 0;
    } else {
      playersTurn = playersTurn == 'X' ? 'O' : 'X';
    }
  }

  bool horizontalCheck(int idx) {
    if (squareTileStates[horizontalKeys[idx][0]] == playersTurn &&
        squareTileStates[horizontalKeys[idx][1]] == playersTurn &&
        squareTileStates[horizontalKeys[idx][2]] == playersTurn) {
      if (playersTurn == 'X') {
        XWins += 1;
        return true;
      }
      OWins += 1;
      return true;
    }
    return false;
  }

  bool verticalCheck(int idx) {
    if (squareTileStates[verticalKeys[idx][0]] == playersTurn &&
        squareTileStates[verticalKeys[idx][1]] == playersTurn &&
        squareTileStates[verticalKeys[idx][2]] == playersTurn) {
      if (playersTurn == 'X') {
        XWins += 1;
        return true;
      }
      OWins += 1;
      return true;

    }
    return false;
  }

  bool diagonalCheck(int idx) {
    if (idx == 4) {
      return false;
    }
    if (squareTileStates[diagonalKeys[idx][0]] == playersTurn &&
        squareTileStates[diagonalKeys[idx][1]] == playersTurn &&
        squareTileStates[diagonalKeys[idx][2]] == playersTurn) {
      if (playersTurn == 'X') {
        XWins += 1;
        return true;
      }
      OWins += 1;
      return true;
    }
    return false;
  }

  void updateSquareTileState(Key key) {
    if (squareTileStates[key] == null) {
      squareTileStates[key] = playersTurn;
      updateSquareTileColors(key);
      checkWin(key);
      notifyListeners();
    }
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic Tac Toe',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text('Tic Tac Toe'),
          ),
          backgroundColor: Colors.blueAccent,
        ),
        body: Center(
          child: Consumer<TicTacToeModel>(
            builder: (context, model, child) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Player X\n${model.XWins} win(s)',
                        style: const TextStyle(fontSize: 30),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        width: 50,
                      ),
                      Text(
                        'Player O\n${model.OWins} win(s)',
                        style: const TextStyle(fontSize: 30),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SquareTile(key: Key('0')),
                        SquareTile(key: Key('1')),
                        SquareTile(key: Key('2')),
                      ]),
                  const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SquareTile(key: Key('3')),
                        SquareTile(key: Key('4')),
                        SquareTile(key: Key('5')),
                      ]),
                  const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SquareTile(key: Key('6')),
                        SquareTile(key: Key('7')),
                        SquareTile(key: Key('8')),
                      ]),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class SquareTile extends StatefulWidget {
  const SquareTile({required Key key}) : super(key: key);
  @override
  State<SquareTile> createState() => _SquareTileState();
}

class _SquareTileState extends State<SquareTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Provider.of<TicTacToeModel>(context, listen: false)
            .updateSquareTileState(widget.key!);
      },
      child: SizedBox(
        width: 100,
        height: 100,
        child: Consumer<TicTacToeModel>(
          builder: (context, model, child) {
            return Container(
              margin: const EdgeInsets.all(1),
              color: model.squareTileColors[widget.key] ?? Colors.purple,
              child: Center(
                child: Text(
                  model.squareTileStates[widget.key] ?? '',
                  style: const TextStyle(fontSize: 50),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
