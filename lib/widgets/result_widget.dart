import 'package:flutter/material.dart';

class ResultWidget extends StatelessWidget implements PreferredSizeWidget {
  final bool? winner;
  final Function()? onRestart;

  const ResultWidget({
    super.key,
    required this.winner,
    required this.onRestart,
  });

  MaterialColor _getColor() {
    switch (winner) {
      case true:
        return Colors.green;
      case false:
        return Colors.red;
      default:
        return Colors.yellow;
    }
  }

  IconData _getIcon() {
    switch (winner) {
      case true:
        return Icons.sentiment_very_satisfied;
      case false:
        return Icons.sentiment_dissatisfied;
      default:
        return Icons.sentiment_satisfied;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(8),
          child: CircleAvatar(
            backgroundColor: _getColor(),
            child: IconButton(
              padding: const EdgeInsets.all(0),
              icon: Icon(
                _getIcon(),
                color: Colors.black,
                size: 36,
              ),
              onPressed: onRestart,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(120);
}
