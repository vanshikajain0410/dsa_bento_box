import 'package:flutter/foundation.dart';

class TicTacToeController extends ChangeNotifier {
  List<String> board = List.generate(9, (_) => '');
  String currentPlayer = 'X';
  String winner = '';
  bool isGameOver = false;

  void playMove(int index) {
    if (board[index] != '' || isGameOver) return;

    board[index] = currentPlayer;

    if (_checkWinner()) {
      winner = currentPlayer;
      isGameOver = true;
    } else if (!board.contains('')) {
      winner = 'Draw';
      isGameOver = true;
    } else {
      currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
    }

    notifyListeners();
  }

  bool _checkWinner() {
    List<List<int>> winPatterns = [
      [0,1,2],[3,4,5],[6,7,8],
      [0,3,6],[1,4,7],[2,5,8],
      [0,4,8],[2,4,6],
    ];

    for (var pattern in winPatterns) {
      if (board[pattern[0]] != '' &&
          board[pattern[0]] == board[pattern[1]] &&
          board[pattern[1]] == board[pattern[2]]) {
        return true;
      }
    }
    return false;
  }

  void resetGame() {
    board = List.generate(9, (_) => '');
    currentPlayer = 'X';
    winner = '';
    isGameOver = false;
    notifyListeners();
  }
}