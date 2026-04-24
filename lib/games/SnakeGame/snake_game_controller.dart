import 'dart:async';
import 'dart:collection';
import 'dart:math';
import 'package:flutter/foundation.dart';

enum Direction { up, down, left, right }

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

class SnakeGameController extends ChangeNotifier {
  final int gridSize = 20;
  final Random _random = Random();

  Queue<Position> snake = Queue(); // Queue data structure for snake body
  Position? food;
  Direction currentDirection = Direction.right;
  Direction nextDirection = Direction.right;
  bool isPlaying = false;
  bool isGameOver = false;
  int score = 0;
  Timer? _timer;

  SnakeGameController() {
    _initGame();
  }

  void _initGame() {
    // Initialize snake in center
    snake.clear();
    snake.add(Position(gridSize ~/ 2, gridSize ~/ 2));
    snake.add(Position(gridSize ~/ 2 - 1, gridSize ~/ 2));
    snake.add(Position(gridSize ~/ 2 - 2, gridSize ~/ 2));

    currentDirection = Direction.right;
    nextDirection = Direction.right;
    score = 0;
    isGameOver = false;
    _generateFood();
    notifyListeners();
  }

  void _generateFood() {
    do {
      food = Position(_random.nextInt(gridSize), _random.nextInt(gridSize));
    } while (snake.contains(food)); // Ensure food doesn't spawn on snake
  }

  void startGame() {
    if (isPlaying) return;
    
    _initGame();
    isPlaying = true;

    _timer?.cancel();
    _timer = Timer.periodic(
      const Duration(milliseconds: 200),
      (_) => _update(),
    );
    notifyListeners();
  }

  void changeDirection(Direction newDirection) {
    // Prevent 180-degree turns
    if ((currentDirection == Direction.up && newDirection == Direction.down) ||
        (currentDirection == Direction.down && newDirection == Direction.up) ||
        (currentDirection == Direction.left && newDirection == Direction.right) ||
        (currentDirection == Direction.right && newDirection == Direction.left)) {
      return;
    }
    nextDirection = newDirection;
  }

  void _update() {
    if (!isPlaying || isGameOver) return;

    currentDirection = nextDirection;
    Position head = snake.first;
    Position newHead;

    // Calculate new head position
    switch (currentDirection) {
      case Direction.up:
        newHead = Position(head.x, head.y - 1);
        break;
      case Direction.down:
        newHead = Position(head.x, head.y + 1);
        break;
      case Direction.left:
        newHead = Position(head.x - 1, head.y);
        break;
      case Direction.right:
        newHead = Position(head.x + 1, head.y);
        break;
    }

    // Check wall collision
    if (newHead.x < 0 || newHead.x >= gridSize || 
        newHead.y < 0 || newHead.y >= gridSize) {
      _endGame();
      return;
    }

    // Check self collision
    if (snake.contains(newHead)) {
      _endGame();
      return;
    }

    // Add new head (enqueue)
    snake.addFirst(newHead);

    // Check if food eaten
    if (newHead == food) {
      score += 10;
      _generateFood();
    } else {
      // Remove tail if no food eaten (dequeue)
      snake.removeLast();
    }

    notifyListeners();
  }

  void _endGame() {
    isGameOver = true;
    isPlaying = false;
    _timer?.cancel();
    notifyListeners();
  }

  void pauseGame() {
    if (!isPlaying) return;
    _timer?.cancel();
    isPlaying = false;
    notifyListeners();
  }

  void resumeGame() {
    if (isPlaying || isGameOver) return;
    isPlaying = true;
    _timer = Timer.periodic(
      const Duration(milliseconds: 200),
      (_) => _update(),
    );
    notifyListeners();
  }

  void restartGame() {
    _timer?.cancel();
    isPlaying = false;
    startGame();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}