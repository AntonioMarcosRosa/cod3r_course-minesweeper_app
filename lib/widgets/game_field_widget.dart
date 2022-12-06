import 'package:flutter/material.dart';
import 'package:minesweeper/models/game_field.dart';

class GameFieldWidget extends StatelessWidget {
  final GameField gameField;
  final Function(GameField) onOpen;
  final Function(GameField) toggleMarkup;

  const GameFieldWidget({
    super.key,
    required this.gameField,
    required this.onOpen,
    required this.toggleMarkup,
  });

  Widget _getGameFieldImage() {
    if (gameField.open && gameField.mined && gameField.exploded) {
      return Image.asset('lib/assets/images/mine_0.jpeg');
    } else if (gameField.open && gameField.mined) {
      return Image.asset('lib/assets/images/mine_1.jpeg');
    } else if (gameField.open) {
      return Image.asset(
          'lib/assets/images/open_${gameField.minesInTheNeighborhood}.jpeg');
    } else if(gameField.marked) {
      return Image.asset('lib/assets/images/flag.jpeg');
    } 
    
    else {
      return Image.asset('lib/assets/images/closed.jpeg');
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onOpen(gameField),
      onLongPress: () => toggleMarkup(gameField),
      child: _getGameFieldImage(),
    );
  }
}
