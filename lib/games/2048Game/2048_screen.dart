import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'game_2048_controller.dart';

class NumberGameScreen extends StatelessWidget {
  const NumberGameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => Game2048Controller(),
      child: Scaffold(
        appBar: AppBar(title: const Text('2048')),
        body: Consumer<Game2048Controller>(
          builder: (context, controller, _) {
            return Column(
              children: [
                const SizedBox(height: 10),

                // ✅ Score Display
                Text(
                  "Score: ${controller.score}",
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                // ✅ GAME GRID WITH SWIPE
                Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque, // ✅ VERY IMPORTANT

                    onPanEnd: (details) {
                      final velocity = details.velocity.pixelsPerSecond;

                      if (velocity.dx.abs() > velocity.dy.abs()) {
                        // Horizontal swipe
                        if (velocity.dx > 0) {
                          controller.move(MoveDirection.right);
                        } else {
                          controller.move(MoveDirection.left);
                        }
                      } else {
                        // Vertical swipe
                        if (velocity.dy > 0) {
                          controller.move(MoveDirection.down);
                        } else {
                          controller.move(MoveDirection.up);
                        }
                      }
                    },

                    child: Container(
                      margin: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(12),
                      ),

                      child: GridView.builder(
                        physics:
                            const NeverScrollableScrollPhysics(), // ✅ keep this
                        itemCount: 16,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                            ),
                        itemBuilder: (context, index) {
                          int i = index ~/ 4;
                          int j = index % 4;
                          int value = controller.grid[i][j];

                          return Container(
                            margin: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: _getTileColor(value),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text(
                                value == 0 ? '' : '$value',
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // ✅ Restart Button
                ElevatedButton(
                  onPressed: controller.restart,
                  child: const Text("Restart"),
                ),

                const SizedBox(height: 20),
              ],
            );
          },
        ),
      ),
    );
  }
}

// 🎨 Tile Colors (makes UI look MUCH better)
Color _getTileColor(int value) {
  switch (value) {
    case 2:
      return Colors.grey.shade300;
    case 4:
      return Colors.grey.shade400;
    case 8:
      return Colors.orange.shade300;
    case 16:
      return Colors.orange.shade400;
    case 32:
      return Colors.deepOrange.shade300;
    case 64:
      return Colors.deepOrange.shade400;
    case 128:
      return Colors.yellow.shade600;
    case 256:
      return Colors.yellow.shade700;
    case 512:
      return Colors.amber.shade600;
    case 1024:
      return Colors.amber.shade700;
    case 2048:
      return Colors.green.shade600;
    default:
      return Colors.grey.shade200;
  }
}
