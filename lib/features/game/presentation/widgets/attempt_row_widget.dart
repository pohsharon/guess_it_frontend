import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guess_it_frontend/core/theme/app_colors.dart';
import 'package:guess_it_frontend/features/game/presentation/bloc/game_bloc.dart';
import 'package:guess_it_frontend/features/game/presentation/bloc/game_state.dart';
import 'package:guess_it_frontend/features/game/presentation/widgets/letter_box_widget.dart';

class AttemptRowWidget extends StatelessWidget {
  final int attemptIndex;

  const AttemptRowWidget({super.key, required this.attemptIndex});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameBloc, GameState>(
      builder: (context, state) {
        final word = state.word ?? '';
        final previousAttempts = state.attempts ?? [];
        final currentAttempt = state.currentAttempt ?? '';
        final isCurrentAttempt = attemptIndex == previousAttempts.length;
        return Row(
          children: List.generate(word.length, (letterIndex) {
            var text = _getLetter(letterIndex, attemptIndex, previousAttempts,
                currentAttempt, isCurrentAttempt);
            var boxColor = _getBoxColor(
                context,
                text,
                word,
                attemptIndex,
                letterIndex,
                previousAttempts,
                isCurrentAttempt);
            var textColor = _getTextColor(
                context,
                text,
                word,
                attemptIndex,
                letterIndex,
                previousAttempts,
                isCurrentAttempt);
            return Expanded(
                child: LetterBoxWidget(
                    text: text,
                    boxColor: boxColor,
                    textColor: textColor));
          }),
        );
      },
    );
  }

  String _getLetter(int letterIndex,
      int attemptIndex,
      List<String> previousAttempts,
      String currentAttempt,
      bool isCurrentAttempt) {
    if (attemptIndex < previousAttempts.length) {
      return previousAttempts[attemptIndex][letterIndex];
    } else if (isCurrentAttempt) {
      return letterIndex < currentAttempt.length
          ? currentAttempt[letterIndex]
          : '';
    }
    return '';
  }

  Color? _getBoxColor(BuildContext context,
      String letter,
      String word,
      int attemptIndex,
      int letterIndex,
      List<String> previousAttempts,
      bool isCurrentAttempt) {
    if (attemptIndex >= previousAttempts.length ||
        letter.isEmpty ||
        isCurrentAttempt) {
      return null;
    } else if (word[letterIndex] == letter) {
      return AppColors.green;
    } else if (word.contains(letter)) {
      return AppColors.yellow;
    }
    return Theme
        .of(context)
        .colorScheme
        .onSurfaceVariant;
  }

  Color? _getTextColor(BuildContext context,
      String letter,
      String word,
      int attemptIndex,
      int letterIndex,
      List<String> previousAttempts,
      bool isCurrentAttempt) {
    if (attemptIndex >= previousAttempts.length ||
        letter.isEmpty ||
        isCurrentAttempt) {
      Theme
          .of(context)
          .colorScheme
          .onSurface;
    }
    else if (word[letterIndex] == letter || word.contains(letter)) {
      return Theme
          .of(context)
          .colorScheme
          .surface;
    }
    return Theme
        .of(context)
        .colorScheme
        .onSurface;
  }


}
