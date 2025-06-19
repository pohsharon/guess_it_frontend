import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:guess_it_frontend/core/theme/app_colors.dart';

class LossDialog extends StatelessWidget {
  final String word;
  final VoidCallback onReplay;

  const LossDialog({
    super.key,
    required this.word,
    required this.onReplay,
  });

  @override
  Widget build(BuildContext context) {
    final Color surfaceColor = Theme.of(context).colorScheme.surface;

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      backgroundColor: const Color.fromARGB(255, 228, 227, 226),
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "😢",
            style: TextStyle(fontSize: 60),
          ),
          const SizedBox(height: 16),
          Text(
            'You Lost!',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color:  Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'The correct word was:\n"$word"',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.black,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Home Button
              ElevatedButton.icon(
                onPressed: () {
                  context.pop(); // Close dialog
                  context.pop(); // Back to home
                },
                icon: const Icon(Icons.home),
                label: const Text('Home'),
                style: ElevatedButton.styleFrom(
                  // backgroundColor: surfaceColor,
                  // foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  textStyle: const TextStyle(fontSize: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
