import 'dart:math';

import 'package:minesweeper/models/game_field.dart';

class GameBoard {
  final int rows;
  final int columns;
  final int amountOfBombs;
  final List<GameField> _gameFields = [];

  GameBoard({
    required this.rows,
    required this.columns,
    required this.amountOfBombs,
  }) {
    _createGameFields();
    _relateNeighbors();
    _placeMines();
  }

  void restart() {
    _gameFields.forEach((gameField) => gameField.restart());
    _placeMines();
  }

  void revealMines() {
    _gameFields.forEach((gameField) => gameField.revealMines());
  }

  void _createGameFields() {
    for (int row = 0; row < rows; row++) {
      for (int column = 0; column < columns; column++) {
        _gameFields.add(GameField(row: row, column: column));
      }
    }
  }

  void _relateNeighbors() {
    for (GameField gameField in _gameFields) {
      for (GameField neigbour in _gameFields) {
        gameField.addNeighbour(neigbour);
      }
    }
  }

  void _placeMines() {
    int placed = 0;

    if (amountOfBombs > rows * columns) return;

    while (placed < amountOfBombs) {
      int bombPosition = Random().nextInt(_gameFields.length);

      if (!_gameFields[bombPosition].mined) {
        placed++;
        _gameFields[bombPosition].undermine();
      }
    }
  }

  List<GameField> get gameFields => _gameFields;

  bool get resolved =>
      _gameFields.every((gameField) => gameField.resolvedGameFild);
}
