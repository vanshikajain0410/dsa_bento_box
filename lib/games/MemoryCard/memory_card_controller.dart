import 'dart:math';
import 'package:flutter/foundation.dart';

class MemoryCardController extends ChangeNotifier {
  List<int> cards = [];
  List<bool> revealed = [];
  List<bool> matched = [];

  int? firstIndex;
  int? secondIndex;

  MemoryCardController() {
    _initGame();
  }

  void _initGame() {
    List<int> base = List.generate(8, (i) => i);
    cards = [...base, ...base];
    cards.shuffle(Random());

    revealed = List.generate(16, (_) => false);
    matched = List.generate(16, (_) => false);

    firstIndex = null;
    secondIndex = null;
    notifyListeners();
  }

  void flipCard(int index) {
    if (revealed[index] || matched[index]) return;

    revealed[index] = true;

    if (firstIndex == null) {
      firstIndex = index;
    } else {
      secondIndex = index;
      _checkMatch();
    }

    notifyListeners();
  }

  void _checkMatch() async {
    if (cards[firstIndex!] == cards[secondIndex!]) {
      matched[firstIndex!] = true;
      matched[secondIndex!] = true;
    } else {
      await Future.delayed(const Duration(milliseconds: 700));
      revealed[firstIndex!] = false;
      revealed[secondIndex!] = false;
    }

    firstIndex = null;
    secondIndex = null;
    notifyListeners();
  }

  void restart() {
    _initGame();
  }
}