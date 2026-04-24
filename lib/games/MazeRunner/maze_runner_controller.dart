import 'dart:collection';
import 'dart:math';
import 'package:flutter/foundation.dart';

class Position {
  final int x;
  final int y;

  Position(this.x, this.y);

  @override
  bool operator ==(Object other) =>
      other is Position && other.x == x && other.y == y;

  @override
  int get hashCode => x.hashCode ^ y.hashCode;
}

class MazeRunnerController extends ChangeNotifier {
  final int size = 10;
  final Random _random = Random();

  late List<List<int>> maze;

  Position player = Position(0, 0);
  Position goal = Position(9, 9);

  bool isGameOver = false;

  MazeRunnerController() {
    generateMaze();
  }

  // 🔥 Generate solvable maze
  void generateMaze() {
    do {
      maze = List.generate(
        size,
        (_) => List.generate(size, (_) => _random.nextInt(3) == 0 ? 1 : 0),
      );

      maze[0][0] = 0;
      maze[size - 1][size - 1] = 0;
    } while (!_isSolvable());

    player = Position(0, 0);
    goal = Position(size - 1, size - 1);
    isGameOver = false;

    notifyListeners();
  }

  // 🧠 BFS to check solvability
  bool _isSolvable() {
    Queue<Position> queue = Queue();
    Set<Position> visited = {};

    queue.add(Position(0, 0));
    visited.add(Position(0, 0));

    List<Position> directions = [
      Position(1, 0),
      Position(-1, 0),
      Position(0, 1),
      Position(0, -1),
    ];

    while (queue.isNotEmpty) {
      Position current = queue.removeFirst();

      if (current.x == size - 1 && current.y == size - 1) {
        return true;
      }

      for (var dir in directions) {
        int nx = current.x + dir.x;
        int ny = current.y + dir.y;

        Position next = Position(nx, ny);

        if (nx >= 0 &&
            ny >= 0 &&
            nx < size &&
            ny < size &&
            maze[nx][ny] == 0 &&
            !visited.contains(next)) {
          queue.add(next);
          visited.add(next);
        }
      }
    }

    return false;
  }

  // 🎮 Movement
  void move(int dx, int dy) {
    if (isGameOver) return;

    int nx = player.x + dx;
    int ny = player.y + dy;

    if (nx >= 0 &&
        ny >= 0 &&
        nx < size &&
        ny < size &&
        maze[nx][ny] == 0) {
      player = Position(nx, ny);

      if (player == goal) {
        isGameOver = true;
      }

      notifyListeners();
    }
  }

  void restart() {
    generateMaze();
  }
}