import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:guess_it_frontend/core/theme/app_colors.dart';
import 'package:guess_it_frontend/features/game/domain/game_repository.dart';

class WinDialog extends StatefulWidget {
  final String word;
  final VoidCallback onReplay;
  final bool isDefinitionView;
  final GameRepository gameRepository;

  const WinDialog({
    super.key,
    required this.word,
    required this.onReplay,
    required this.gameRepository,
    this.isDefinitionView = false,
  });

  @override
  State<WinDialog> createState() => _WinDialogState();
}

class _WinDialogState extends State<WinDialog> {
  String? meaning;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    if (widget.isDefinitionView) {
      _fetchMeaning();
    }
  }

  Future<void> _fetchMeaning() async {
    setState(() => loading = true);
    final result = await widget.gameRepository.wordMeaning(widget.word);
    result.fold(
      (failure) {
        setState(() {
          meaning = failure.message;
          loading = false;
        });
      },
      (value) {
        setState(() {
          meaning = value;
          loading = false;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final surfaceColor = Theme.of(context).colorScheme.surface;

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      backgroundColor: const Color.fromARGB(255, 228, 227, 226),
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(widget.isDefinitionView ? "📘" : "🎉", style: const TextStyle(fontSize: 60)),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  widget.isDefinitionView ? 'Word Meaning' : 'You Nailed It!',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              if (!widget.isDefinitionView) ...[
                const SizedBox(width: 8),
                Tooltip(
                  message: 'See word meaning',
                  child: IconButton(
                    icon: const Icon(Icons.info_outline, color: Colors.black54),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => WinDialog(
                          word: widget.word,
                          onReplay: widget.onReplay,
                          isDefinitionView: true,
                          gameRepository: widget.gameRepository, // pass it again
                        ),
                      );
                    },
                  ),
                ),
              ]
            ],
          ),
          const SizedBox(height: 12),
          if (widget.isDefinitionView)
            loading
                ? const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: CircularProgressIndicator(),
                  )
                : Text(
                    '"${widget.word}":\n${meaning ?? 'No definition available.'}',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                  )
          else
            Text(
              'Awesome job guessing the word:\n"${widget.word}"',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.black,
                    fontSize: 16,
                  ),
            ),
          const SizedBox(height: 24),
          if (!widget.isDefinitionView)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    context.pop();
                    context.pop();
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
