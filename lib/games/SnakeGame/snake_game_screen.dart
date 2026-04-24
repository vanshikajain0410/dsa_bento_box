import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'snake_game_controller.dart';

class SnakeScreen extends StatelessWidget {
  const SnakeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SnakeGameController(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Snake Game'),
          backgroundColor: Colors.green[700],
        ),
        body: Consumer<SnakeGameController>(
          builder: (context, controller, _) {
            return Column(
              children: [
                // Score Display
                Container(
                  padding: const EdgeInsets.all(16),
                  color: Colors.green[100],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Score: ${controller.score}',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Length: ${controller.snake.length}',
                        style: const TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),

                // Game Grid
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.green, width: 3),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.gridSize * controller.gridSize,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: controller.gridSize,
                      ),
                      itemBuilder: (context, index) {
                        final x = index % controller.gridSize;
                        final y = index ~/ controller.gridSize;
                        final position = Position(x, y);

                        final isSnakeHead = controller.snake.isNotEmpty &&
                            controller.snake.first == position;
                        final isSnakeBody = controller.snake.contains(position);
                        final isFood = controller.food == position;

                        Color cellColor = Colors.green[50]!;
                        if (isSnakeHead) {
                          cellColor = Colors.green[900]!;
                        } else if (isSnakeBody) {
                          cellColor = Colors.green[600]!;
                        } else if (isFood) {
                          cellColor = Colors.red[600]!;
                        }

                        return Container(
                          margin: const EdgeInsets.all(1),
                          decoration: BoxDecoration(
                            color: cellColor,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                // Game Over Overlay
                if (controller.isGameOver)
                  Positioned.fill(
                    child: Container(
                      color: Colors.black54,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Game Over!',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 48,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Score: ${controller.score}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 32,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                // Controls
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      // D-Pad Controls
                      Column(
                        children: [
                          IconButton(
                            iconSize: 48,
                            onPressed: () => controller.changeDirection(Direction.up),
                            icon: const Icon(Icons.arrow_upward),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                iconSize: 48,
                                onPressed: () =>
                                    controller.changeDirection(Direction.left),
                                icon: const Icon(Icons.arrow_back),
                              ),
                              const SizedBox(width: 80),
                              IconButton(
                                iconSize: 48,
                                onPressed: () =>
                                    controller.changeDirection(Direction.right),
                                icon: const Icon(Icons.arrow_forward),
                              ),
                            ],
                          ),
                          IconButton(
                            iconSize: 48,
                            onPressed: () =>
                                controller.changeDirection(Direction.down),
                            icon: const Icon(Icons.arrow_downward),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      // Game Control Buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (!controller.isPlaying && !controller.isGameOver)
                            ElevatedButton(
                              onPressed: controller.startGame,
                              child: const Text('Start Game'),
                            ),
                          if (controller.isPlaying)
                            ElevatedButton(
                              onPressed: controller.pauseGame,
                              child: const Text('Pause'),
                            ),
                          if (!controller.isPlaying && !controller.isGameOver)
                            const SizedBox(width: 12),
                          if (!controller.isPlaying && !controller.isGameOver)
                            ElevatedButton(
                              onPressed: controller.resumeGame,
                              child: const Text('Resume'),
                            ),
                          if (controller.isGameOver) ...[
                            ElevatedButton(
                              onPressed: controller.restartGame,
                              child: const Text('Play Again'),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}