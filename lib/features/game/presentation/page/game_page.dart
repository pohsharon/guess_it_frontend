import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guess_it_frontend/core/get_it/get_it.dart';
import 'package:guess_it_frontend/features/game/domain/game_repository.dart';
import 'package:guess_it_frontend/features/game/presentation/bloc/game_bloc.dart';
import 'package:guess_it_frontend/features/game/presentation/bloc/game_event.dart';
import 'package:guess_it_frontend/features/game/presentation/bloc/game_state.dart';
import 'package:guess_it_frontend/features/game/presentation/widgets/attempts_widget.dart';
import 'package:guess_it_frontend/features/game/presentation/widgets/game_keyboard.dart';
import 'package:guess_it_frontend/features/game/presentation/widgets/loss_dialog.dart';
import 'package:guess_it_frontend/features/game/presentation/widgets/win_dialog.dart';

class GamePage extends StatelessWidget {
  final int attemptsCount;
  final int wordLength;

  const GamePage(
      {super.key, required this.attemptsCount, required this.wordLength});

  static String route({required int wordLength, required int attemptsCount}) =>
      Uri(path: '/game', queryParameters: {
        'attemptsCount': attemptsCount.toString(),
        'wordLength': wordLength.toString()
      }).toString();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<GameBloc>()
        ..add(StartGameEvent(
            attemptsCount: attemptsCount, wordLength: wordLength)),
      child: BlocConsumer<GameBloc, GameState>(
        builder: (context, state) {
          if (state.status == GameStatus.loading) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator.adaptive(),
              ),
            );
          }
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Spelling Bee',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            body: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                const AttemptsWidget(),
                const Spacer(),
                GameKeyboard(
                  onKeyPressed: (v) {
                    context.read<GameBloc>().add(EnterKeyEvent(key: v));
                  },
                  onDelete: () {
                    context.read<GameBloc>().add(DeleteKeyEvent());
                  },
                  onSubmit: () {
                    context.read<GameBloc>().add(EnterAttemptEvent());
                  },
                )
              ],
            ),
          );
        },
        listener: (context, state) {
          if (state.status == GameStatus.win) {
            showDialog(
                context: context,
                builder: (context) {
                  return WinDialog(
                    word: state.word ?? '',
                    onReplay: () => context.read<GameBloc>().add(StartGameEvent(
                        attemptsCount: attemptsCount, wordLength: wordLength)),
                    gameRepository: getIt<GameRepository>(), // ✅ get from DI
                  );
                },
                barrierDismissible: false);
          } else if (state.status == GameStatus.loss) {
            showDialog(
                context: context,
                builder: (context) {
                  return LossDialog(
                    word: state.word ?? '',
                    onReplay: () => context.read<GameBloc>().add(StartGameEvent(
                        attemptsCount: attemptsCount, wordLength: wordLength)),
                    gameRepository: getIt<GameRepository>(),
                  );
                },
                barrierDismissible: false);
          } else if (state.status == GameStatus.error) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('${state.errorMessage}')));
          }
        },
      ),
    );
  }
}
