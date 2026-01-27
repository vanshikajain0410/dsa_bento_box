import 'package:flutter/material.dart';

class GameTile {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final int flex;
  final Widget screen;

  GameTile({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.flex,
    required this.screen,
  });
}