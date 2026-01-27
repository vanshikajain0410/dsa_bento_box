import 'package:dsa_bento_box/Dashboard/data/game_tile_data.dart';
import 'package:dsa_bento_box/Dashboard/screens/screens.dart';
import 'package:dsa_bento_box/Dashboard/widget/game_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DSA Bento Box'),
        backgroundColor: const Color.fromARGB(255, 213, 228, 227),
      ),
      backgroundColor: Colors.grey.shade300,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StaggeredGrid.count(
          crossAxisCount: 4,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          children: [
            // Snake Game - takes 2 columns, 4 rows
            StaggeredGridTile.count(
              crossAxisCellCount: 2,
              mainAxisCellCount: 4,
              child: GameCard(
                title: 'Snake\nGame',
                color: const Color.fromARGB(255, 209, 173, 174),
                onTap: () => openScreen(context, const SnakeScreen()),
              ),
            ),
            // Project Catalog - takes 2 columns, 1.5 rows
            StaggeredGridTile.count(
              crossAxisCellCount: 2,
              mainAxisCellCount: 1.5,
              child: GameCard(
                title: 'Project\nCatalog',
                color: const Color(0xFF2C3E50),
                onTap: () => openScreen(context, const ProjectCatalogScreen()),
              ),
            ),
            // Placeholder - takes 2 columns, 2.5 rows
            StaggeredGridTile.count(
              crossAxisCellCount: 2,
              mainAxisCellCount: 2.5,
              child: GameCard(
                title: '2048',
                color: const Color(0xFF5D7FA3),
                onTap: () => openScreen(context, const NumberGameScreen()),
              ),
            ),
            // Dijkstra Map - takes full width (4 columns), 2 rows
            StaggeredGridTile.count(
              crossAxisCellCount: 4,
              mainAxisCellCount: 2,
              child: GameCard(
                title: 'Maze\nRunner',
                color: const Color(0xFF5FA8A8),
                onTap: () => openScreen(context, const MazeRunner()),
              ),
            ),
            // Feature 1 - takes 1.33 columns, 1 row
            StaggeredGridTile.count(
              crossAxisCellCount: 2,
              mainAxisCellCount: 1,
              child: GameCard(
                title: 'Whack A\nMole',
                color: const Color(0xFFE8C574),
                onTap: () => openScreen(context, const WhackAMole()),
              ),
            ),

            // Feature 2 - takes 1.33 columns, 1 row
            StaggeredGridTile.count(
              crossAxisCellCount: 2,
              mainAxisCellCount: 2,
              child: GameCard(
                title: 'TIC\nTAC\nTOE',
                color: const Color(0xFF1E293B),

                onTap: () => openScreen(context, const TicTacToeScreen()),
              ),
            ),
            // Memory Card - takes 1.33 columns, 1 row
            StaggeredGridTile.count(
              crossAxisCellCount: 2,
              mainAxisCellCount: 1,
              child: GameCard(
                title: 'Memory\nCard',
                color: const Color(0xFFD4A574),
                onTap: () => openScreen(context, const MemoryCard()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class TopSection extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [

//         ],
//     );
//   }
// }

// class MiddleSection extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return GameCard(tile: gameTiles[3]);
//   }
// }

// class BottomSection extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Expanded(child: GameCard(tile: gameTiles[4])),
//         const SizedBox(width: 16),
//         Expanded(child: GameCard(tile: gameTiles[5])),
//         const SizedBox(width: 16),
//         Expanded(child: GameCard(tile: gameTiles[6])),
//       ],
//     );
//   }
// }

void openScreen(BuildContext context, Widget screen) {
  Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
}
