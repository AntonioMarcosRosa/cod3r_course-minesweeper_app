import 'package:flutter/material.dart';
import 'package:minesweeper/models/explosion_exception.dart';
import 'package:minesweeper/models/game_board.dart';
import 'package:minesweeper/models/game_field.dart';
import 'package:minesweeper/widgets/result_widget.dart';

import '../widgets/game_board_widget.dart';

class MinesweeperApp extends StatefulWidget {
  const MinesweeperApp({super.key});

  @override
  State<MinesweeperApp> createState() => _MinesweeperAppState();
}

class _MinesweeperAppState extends State<MinesweeperApp> {
  bool? _winner;

  GameBoard? _gameBoard;

  void _restart() {
    setState(() {
      _winner = null;
      _gameBoard!.restart();
    });
  }

  void _open(GameField gameField) {
    setState(() {
      if (_winner != null) return;
      try {
        gameField.openGameField();
        if (_gameBoard!.resolved) _winner = true;
      } on ExplosionException {
        _winner = false;
        _gameBoard!.revealMines();
      }
    });
  }

  void _togglemarkup(GameField gameField) {
    setState(() {
      try {
        gameField.toggleMarkup();
        if (_gameBoard!.resolved) _winner = true;
      } on ExplosionException {}
    });
  }

  GameBoard _getGameBoard(double screenWidth, double screenHeight) {
    if (_gameBoard == null) {
      int amountOfColumns = 15;
      double gameFieldSize = screenWidth / amountOfColumns;
      int amountOfRows = (screenHeight / gameFieldSize).floor();

      _gameBoard = GameBoard(
        rows: amountOfRows,
        columns: amountOfColumns,
        amountOfBombs: 20,
      );
    }
    return _gameBoard!;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: ResultWidget(
          winner: _winner,
          onRestart: _restart,
        ),
        body: Container(
          color: Colors.grey,
          child: LayoutBuilder(
            builder: (context, constrants) {
              return GameBoardWidget(
                gameBoard: _getGameBoard(
                  constrants.maxWidth,
                  constrants.maxHeight,
                ),
                onOpen: _open,
                toggleMarkup: _togglemarkup,
              );
            },
          ),
        ),
      ),
    );
  }
}
