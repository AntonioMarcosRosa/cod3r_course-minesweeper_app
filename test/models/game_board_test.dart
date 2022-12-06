import 'package:flutter_test/flutter_test.dart';
import 'package:minesweeper/models/game_board.dart';

void main() {
  test('Ganhar jogo', () {
    GameBoard gameBoard = GameBoard(
      amountOfBombs: 0,
      rows: 2,
      columns: 2,
    );
    gameBoard.gameFields[0].undermine();
    gameBoard.gameFields[3].undermine();

    gameBoard.gameFields[0].toggleMarkup();
    gameBoard.gameFields[1].openGameField();
    gameBoard.gameFields[2].openGameField();
    gameBoard.gameFields[3].toggleMarkup();

    expect(gameBoard.resolved, isTrue);
  });
}
