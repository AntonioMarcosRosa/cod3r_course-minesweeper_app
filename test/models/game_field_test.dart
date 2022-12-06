import 'package:flutter_test/flutter_test.dart';
import 'package:minesweeper/models/game_field.dart';

main() {
  group('GameField tests', () {
    test('Open GameField with explosion', () {
      GameField gameField = GameField(row: 0, column: 0);
      gameField.undermine();

      expect(gameField.openGameField, throwsException);
    });
    test('Open GameField without explosion', () {
      GameField gameField = GameField(row: 0, column: 0);
      gameField.openGameField();
      expect(gameField.open, isTrue);
    });
    test('Add not neigbour', () {
      GameField gameField = GameField(row: 0, column: 0);
      GameField gameFieldNotNeigbour = GameField(row: 1, column: 3);
      gameField.addNeighbour(gameFieldNotNeigbour);

      expect(gameField.neighbours.isEmpty, isTrue);
    });
    test('Add neigbour', () {
      GameField gameField = GameField(row: 3, column: 3);
      GameField gameFieldNotNeigbour = GameField(row: 3, column: 4);
      GameField gameFieldNotNeigbour2 = GameField(row: 3, column: 2);
      GameField gameFieldNotNeigbour3 = GameField(row: 4, column: 3);
      GameField gameFieldNotNeigbour4 = GameField(row: 2, column: 3);

      gameField.addNeighbour(gameFieldNotNeigbour);
      gameField.addNeighbour(gameFieldNotNeigbour2);
      gameField.addNeighbour(gameFieldNotNeigbour3);
      gameField.addNeighbour(gameFieldNotNeigbour4);

      expect(gameField.neighbours.length, 4);
    });

    test('Mines in the neighborhood', () {
      GameField gameField = GameField(row: 3, column: 3);
      GameField gameFieldNotNeigbour = GameField(row: 3, column: 4);
      GameField gameFieldNotNeigbour2 = GameField(row: 3, column: 2);
      gameFieldNotNeigbour2.undermine();
      GameField gameFieldNotNeigbour3 = GameField(row: 4, column: 3);
      GameField gameFieldNotNeigbour4 = GameField(row: 2, column: 3);
      gameFieldNotNeigbour4.undermine();

      gameField.addNeighbour(gameFieldNotNeigbour);
      gameField.addNeighbour(gameFieldNotNeigbour2);
      gameField.addNeighbour(gameFieldNotNeigbour3);
      gameField.addNeighbour(gameFieldNotNeigbour4);

      expect(gameField.minesInTheNeighborhood, 2);
    });
  });
}
