import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'whack_a_mole_controller.dart';

class WhackAMoleScreen extends StatelessWidget {
  const WhackAMoleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => WhackAMoleController(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Whack A Mole')),
        body: Consumer<WhackAMoleController>(
          builder: (context, controller, _) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Center(
                    child: Text('Player Name', style: TextStyle(fontSize: 24)),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Score: ${controller.score}",
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 20),
              
                  Expanded(
                    child: GridView.builder(
                      itemCount: controller.gridSize,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                      ),
                      itemBuilder: (context, index) {
                        final isMoleActive =
                            index == controller.activeIndex;
              
                        return GestureDetector(
                          onTap: () => controller.hit(index),
                          child: Container(
                            margin: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color:
                                  isMoleActive ? Colors.brown : Colors.green,
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (!controller.isPlaying)
                      ElevatedButton(
                        onPressed: controller.startGame,
                        child: const Text('Start Game'),
                      ),

                    if (controller.isPlaying) ...[
                      ElevatedButton(
                        onPressed: controller.endGame,
                        child: const Text('End Game'),
                      ),
                      const SizedBox(width: 12),
                      ElevatedButton(
                        onPressed: controller.restartGame,
                        child: const Text('Restart'),
                      ),
                    ],
                  ],
                ),

                const SizedBox(height: 50),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
