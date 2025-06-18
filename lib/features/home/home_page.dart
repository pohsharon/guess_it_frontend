import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spelling_bee/features/widgets/slider_selection_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:spelling_bee/features/game/presentation/game_page.dart';
import 'package:spelling_bee/core/get_it/get_it.dart';
import 'package:spelling_bee/features/home/presentation/game_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const String route = '/';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double wordLength = 4;
  double attemptsCount = 4;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<GameBloc>(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Spelling Bee',
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    letterSpacing: 2,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'By Poh Sharon (22004742)',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w400,
                    letterSpacing: 2,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Choose your game settings',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(fontSize: 20),
                ),
                SizedBox(height: 32),
                SliderSelectionWidget(
                  title: 'Word Length',
                  value: wordLength,
                  minValue: 4,
                  maxValue: 7,
                  divisions: 3,
                  onChanged: (value) {
                    setState(() {
                      wordLength = value;
                    });
                  },
                ),
                SizedBox(height: 32),
                SliderSelectionWidget(
                  title: 'Attempts Count',
                  value: attemptsCount,
                  minValue: 3,
                  maxValue: 7,
                  divisions: 4,
                  onChanged: (value) {
                    setState(() {
                      attemptsCount = value;
                    });
                  },
                ),
                Spacer(),
                SizedBox(
                  width: double.maxFinite,
                  child: ElevatedButton(
                    onPressed: () {
                      context.push(
                        GamePage.route(
                          wordLength: wordLength.toInt().toString(),
                          attemptsCount: attemptsCount.toInt().toString(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 18),
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Theme.of(context).colorScheme.surface,
                      elevation: 5,
                      shadowColor: Colors.black.withOpacity(0.3),
                    ),
                    child: Text(
                      'Start Game',
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
