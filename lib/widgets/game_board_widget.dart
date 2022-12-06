import 'package:flutter/material.dart';
import 'package:minesweeper/models/game_board.dart';
import 'package:minesweeper/models/game_field.dart';
import 'package:minesweeper/widgets/game_field_widget.dart';

class GameBoardWidget extends StatelessWidget {
  final GameBoard gameBoard;
  final Function(GameField) onOpen;
  final Function(GameField) toggleMarkup;

  const GameBoardWidget({
    super.key,
    required this.gameBoard,
    required this.onOpen,
    required this.toggleMarkup,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.count(
        crossAxisCount: gameBoard.columns,
        children: gameBoard.gameFields.map((gamefield) => GameFieldWidget(
              gameField: gamefield,
              onOpen: onOpen,
              toggleMarkup: toggleMarkup,
            )).toList(),
      ),
    );
  }
}
