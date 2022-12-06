import 'package:flutter/animation.dart';

import 'explosion_exception.dart';

class GameField {
  final int row;
  final int column;
  final List<GameField> neighbours = [];

  bool _open = false;
  bool _marked = false;
  bool _mined = false;
  bool _exploded = false;

  GameField({
    required this.row,
    required this.column,
  });

  bool get safeNeighborhood =>
      neighbours.every((neigbour) => neigbour.mined == false);

  bool get mined => _mined;

  bool get exploded => _exploded;

  bool get marked => _marked;

  bool get open => _open;

  bool get resolvedGameFild {
    bool minedAndMarked = mined && marked;
    bool safeAndOpen = !mined && open;

    return minedAndMarked || safeAndOpen;
  }

  int get minesInTheNeighborhood =>
      neighbours.where((neigbour) => neigbour.mined).length;

  void addNeighbour(GameField neigbour) {
    final deltaRow = (row - neigbour.row).abs();
    final detalColumn = (column - neigbour.column).abs();

    if (deltaRow == 0 && detalColumn == 0) return;

    if (deltaRow <= 1 && detalColumn <= 1) neighbours.add(neigbour);
  }

  void openGameField() {
    if (_open) return;

    _open = true;

    if (_mined) {
      _exploded = true;
      throw ExplosionException();
    }

    if (safeNeighborhood) {
      neighbours.forEach((neigbour) => neigbour.openGameField());
    }
  }

  void revealMines() {
    if (mined) _open = true;
  }

  void undermine() => _mined = true;

  void toggleMarkup() => _marked = !_marked;

  void restart() {
    _open = false;
    _marked = false;
    _mined = false;
    _exploded = false;
  }
}
