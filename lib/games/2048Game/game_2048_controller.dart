import 'dart:math';
import 'package:flutter/foundation.dart';

enum MoveDirection { left, right, up, down }

class Game2048Controller extends ChangeNotifier {
  List<List<int>> grid = List.generate(4, (_) => List.filled(4, 0));
  final Random _random = Random();
  int score = 0;

  Game2048Controller() {
    _initGame();
  }

  void _initGame() {
  grid = List.generate(4, (_) => List.filled(4, 0));

  score = 0; 

  _addTile();
  _addTile();
  notifyListeners();
}

  void _addTile() {
    List<List<int>> empty = [];

    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        if (grid[i][j] == 0) empty.add([i, j]);
      }
    }

    if (empty.isEmpty) return;

    var pos = empty[_random.nextInt(empty.length)];
    grid[pos[0]][pos[1]] = _random.nextBool() ? 2 : 4;
  }

  List<int> _merge(List<int> line) {
  line = line.where((e) => e != 0).toList();

  for (int i = 0; i < line.length - 1; i++) {
    if (line[i] == line[i + 1]) {
      line[i] *= 2;

      score += line[i]; 

      line[i + 1] = 0;
    }
  }

  line = line.where((e) => e != 0).toList();

  while (line.length < 4) {
    line.add(0);
  }

  return line;
}

  void move(MoveDirection direction) {
    bool moved = false;

    if (direction == MoveDirection.left) {
      for (int i = 0; i < 4; i++) {
        List<int> newRow = _merge(grid[i]);
        if (!_listEqual(grid[i], newRow)) moved = true;
        grid[i] = newRow;
      }
    }

    if (direction == MoveDirection.right) {
      for (int i = 0; i < 4; i++) {
        List<int> reversed = grid[i].reversed.toList();
        reversed = _merge(reversed);
        List<int> newRow = reversed.reversed.toList();
        if (!_listEqual(grid[i], newRow)) moved = true;
        grid[i] = newRow;
      }
    }

    if (direction == MoveDirection.up) {
      for (int col = 0; col < 4; col++) {
        List<int> column = [];
        for (int row = 0; row < 4; row++) {
          column.add(grid[row][col]);
        }

        List<int> newCol = _merge(column);

        for (int row = 0; row < 4; row++) {
          if (grid[row][col] != newCol[row]) moved = true;
          grid[row][col] = newCol[row];
        }
      }
    }

    if (direction == MoveDirection.down) {
      for (int col = 0; col < 4; col++) {
        List<int> column = [];
        for (int row = 0; row < 4; row++) {
          column.add(grid[row][col]);
        }

        List<int> reversed = column.reversed.toList();
        reversed = _merge(reversed);
        List<int> newCol = reversed.reversed.toList();

        for (int row = 0; row < 4; row++) {
          if (grid[row][col] != newCol[row]) moved = true;
          grid[row][col] = newCol[row];
        }
      }
    }

    if (moved) {
      _addTile();
      notifyListeners();
    }
  }

  bool _listEqual(List<int> a, List<int> b) {
    for (int i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }

  void restart() => _initGame();
}