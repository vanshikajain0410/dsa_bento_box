import 'dart:async';
import 'dart:math';
import 'package:flutter/foundation.dart';

class WhackAMoleController extends ChangeNotifier {
  final int gridSize = 9; // 3x3 grid (easy mode)
  final Random _random = Random(); //to generate random mole positions

  int activeIndex = -1;  //current mole index
  int score = 0;
  bool isPlaying = false;
  Timer? _timer;

  void startGame() {
    score = 0; //current score
    isPlaying = true;

    _timer?.cancel(); // safety
    // Generating a new mole position every 800 milliseconds
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        activeIndex = _random.nextInt(gridSize);
        notifyListeners(); //notifies UI about the change
      },
    );
    notifyListeners();
  }

  void hit(int index) {
    if(!isPlaying) return;

    if (index == activeIndex) {
      score++;
      activeIndex = -1;
      notifyListeners();
    }
  }

  void endGame() {
    _timer?.cancel();
    isPlaying = false;
    activeIndex = -1;
    notifyListeners();
  }

  void restartGame() {
    endGame();
    startGame();
  }

}
