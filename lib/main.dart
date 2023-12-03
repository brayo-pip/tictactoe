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

  void checkWin() {
    // ugly but efficient
    if (squareTileStates[const Key('0')] != null &&
            squareTileStates[const Key('0')] ==
                squareTileStates[const Key('1')] &&
            squareTileStates[const Key('1')] ==
                squareTileStates[const Key('2')] ||
        squareTileStates[const Key('3')] != null &&
            squareTileStates[const Key('3')] ==
                squareTileStates[const Key('4')] &&
            squareTileStates[const Key('4')] ==
                squareTileStates[const Key('5')] ||
        squareTileStates[const Key('6')] != null &&
            squareTileStates[const Key('6')] ==
                squareTileStates[const Key('7')] &&
            squareTileStates[const Key('7')] ==
                squareTileStates[const Key('8')] ||
        squareTileStates[const Key('0')] != null &&
            squareTileStates[const Key('0')] ==
                squareTileStates[const Key('3')] &&
            squareTileStates[const Key('3')] ==
                squareTileStates[const Key('6')] ||
        squareTileStates[const Key('1')] != null &&
            squareTileStates[const Key('1')] ==
                squareTileStates[const Key('4')] &&
            squareTileStates[const Key('4')] ==
                squareTileStates[const Key('7')] ||
        squareTileStates[const Key('2')] != null &&
            squareTileStates[const Key('2')] ==
                squareTileStates[const Key('5')] &&
            squareTileStates[const Key('5')] ==
                squareTileStates[const Key('8')] ||
        squareTileStates[const Key('0')] != null &&
            squareTileStates[const Key('0')] ==
                squareTileStates[const Key('4')] &&
            squareTileStates[const Key('4')] ==
                squareTileStates[const Key('8')] ||
        squareTileStates[const Key('2')] != null &&
            squareTileStates[const Key('2')] ==
                squareTileStates[const Key('4')] &&
            squareTileStates[const Key('4')] ==
                squareTileStates[const Key('6')]) {
      if (playersTurn == 'O') {
        XWins += 1;
      } else {
        OWins += 1;
      }
      resetTileColor();
      resetTileState();
    } else if (squareTileStates[const Key('0')] != null &&
        squareTileStates[const Key('1')] != null &&
        squareTileStates[const Key('2')] != null &&
        squareTileStates[const Key('3')] != null &&
        squareTileStates[const Key('4')] != null &&
        squareTileStates[const Key('5')] != null &&
        squareTileStates[const Key('6')] != null &&
        squareTileStates[const Key('7')] != null &&
        squareTileStates[const Key('8')] != null) {
      resetTileColor();
      resetTileState();
    }
  }

  void updateSquareTileState(Key key) {
    if (squareTileStates[key] == null) {
      squareTileStates[key] = playersTurn;
      playersTurn = playersTurn == 'X' ? 'O' : 'X';
      updateSquareTileColors(key);
      checkWin();
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
                      SquareTile(
                        key: Key('0'),
                      ),
                      SquareTile(
                        key: Key('1'),
                      ),
                      SquareTile(
                        key: Key('2'),
                      ),
                    ],
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SquareTile(
                        key: Key('3'),
                      ),
                      SquareTile(
                        key: Key('4'),
                      ),
                      SquareTile(
                        key: Key('5'),
                      ),
                    ],
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SquareTile(
                        key: Key('6'),
                      ),
                      SquareTile(
                        key: Key('7'),
                      ),
                      SquareTile(
                        key: Key('8'),
                      ),
                    ],
                  ),
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
            return Card(
              shape:
                  const BeveledRectangleBorder(borderRadius: BorderRadius.zero),
              elevation: 0,
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
