import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'tic_tac_toe_controller.dart';

class TicTacToeScreen extends StatelessWidget {
  const TicTacToeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TicTacToeController(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Tic Tac Toe')),
        body: Consumer<TicTacToeController>(
          builder: (context, controller, _) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  controller.isGameOver
                      ? "Winner: ${controller.winner}"
                      : "Turn: ${controller.currentPlayer}",
                  style: const TextStyle(fontSize: 24),
                ),
                const SizedBox(height: 20),

                GridView.builder(
                  shrinkWrap: true,
                  itemCount: 9,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => controller.playMove(index),
                      child: Container(
                        margin: const EdgeInsets.all(8),
                        color: Colors.blue[100],
                        child: Center(
                          child: Text(
                            controller.board[index],
                            style: const TextStyle(fontSize: 32),
                          ),
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: controller.resetGame,
                  child: const Text('Restart'),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}