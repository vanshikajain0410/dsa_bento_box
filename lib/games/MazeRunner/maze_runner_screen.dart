import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'maze_runner_controller.dart';

class MazeRunner extends StatelessWidget {
  const MazeRunner({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MazeRunnerController(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Maze Runner')),
        body: Consumer<MazeRunnerController>(
          builder: (context, controller, _) {
            return Column(
              children: [
                const SizedBox(height: 10),

                if (controller.isGameOver)
                  const Text(
                    "🎉 You Reached the Goal!",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),

                // 🧱 Maze Grid
                Expanded(
                  child: GridView.builder(
                    itemCount: controller.size * controller.size,
                    gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: controller.size,
                    ),
                    itemBuilder: (context, index) {
                      int x = index ~/ controller.size;
                      int y = index % controller.size;

                      bool isWall = controller.maze[x][y] == 1;
                      bool isPlayer =
                          controller.player.x == x &&
                          controller.player.y == y;
                      bool isGoal =
                          controller.goal.x == x &&
                          controller.goal.y == y;

                      Color color = Colors.white;

                      if (isWall) color = Colors.black;
                      if (isGoal) color = Colors.green;
                      if (isPlayer) color = Colors.blue;

                      return Container(
                        margin: const EdgeInsets.all(1),
                        color: color,
                      );
                    },
                  ),
                ),

                // 🎮 Controls
                Column(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_upward),
                      onPressed: () => controller.move(-1, 0),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: () => controller.move(0, -1),
                        ),
                        const SizedBox(width: 50),
                        IconButton(
                          icon: const Icon(Icons.arrow_forward),
                          onPressed: () => controller.move(0, 1),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: const Icon(Icons.arrow_downward),
                      onPressed: () => controller.move(1, 0),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

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