import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'memory_card_controller.dart';

class MemoryCard extends StatelessWidget {
  const MemoryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MemoryCardController(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Memory Card')),
        body: Consumer<MemoryCardController>(
          builder: (context, controller, _) {
            return Column(
              children: [
                Expanded(
                  child: GridView.builder(
                    itemCount: 16,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                    ),
                    itemBuilder: (context, index) {
                      bool isVisible =
                          controller.revealed[index] ||
                          controller.matched[index];

                      return GestureDetector(
                        onTap: () => controller.flipCard(index),
                        child: Container(
                          margin: const EdgeInsets.all(6),
                          color: isVisible ? Colors.orange : Colors.grey,
                          child: Center(
                            child: isVisible
                                ? Text(
                                    "${controller.cards[index]}",
                                    style: const TextStyle(fontSize: 24),
                                  )
                                : const Text('?'),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: controller.restart,
                  child: const Text("Restart"),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}