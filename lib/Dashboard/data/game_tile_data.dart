import 'package:dsa_bento_box/Dashboard/models/game_tile.dart';
import 'package:dsa_bento_box/Dashboard/screens/screens.dart';
import 'package:flutter/material.dart';

final List<GameTile> gameTiles = [
  GameTile(
    title: "Snake Game",
    subtitle: "Queue • Collision",
    icon: Icons.all_inclusive,
    color: const Color(0xFFE5C4B8),
    flex: 3,
    screen: const SnakeScreen(),
  ),
  GameTile(
    title: "Project Catalog",
    subtitle: "Browse Projects",
    icon: Icons.folder,
    color: const Color(0xFF2C3E50),
    flex: 2,
    screen: const ProjectCatalogScreen(),
  ),
  GameTile(
    title: "2048",
    subtitle: "",
    icon: Icons.apps,
    color: const Color(0xFF5D7FA3),
    flex: 3,
    screen: const NumberGameScreen(),
  ),
  GameTile(
    title: "Maze Runner",
    subtitle: "Pathfinding • A*",
    icon: Icons.route,
    color: const Color(0xFF5FA8A8),
    flex: 2,
    screen: const MazeRunner(),
  ),
  GameTile(
    title: "Whack A Mole",
    subtitle: "",
    icon: Icons.star,
    color: const Color(0xFFE8C574),
    flex: 1,
    screen: const WhackAMole(),
  ),
  GameTile(
    title: "Memory Card",
    subtitle: "",
    icon: Icons.lightbulb,
    color: const Color(0xFFD4A574),
    flex: 1,
    screen: const MemoryCard(),
  ),
  GameTile(
    title: "Tic Tac Toe",
    subtitle: "Minimax AI",
    icon: Icons.close,
    color: const Color(0xFF1E293B),
    flex: 1,
    screen: const TicTacToeScreen(),
  ),
];