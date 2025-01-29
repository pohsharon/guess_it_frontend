import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guess_it_frontend/features/game/presentation/bloc/game_bloc.dart';
import 'package:guess_it_frontend/features/game/presentation/bloc/game_state.dart';
import 'package:guess_it_frontend/features/game/presentation/widgets/attempt_row_widget.dart';

class AttemptsWidget extends StatelessWidget {
  const AttemptsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameBloc, GameState>(
      builder: (context, state) {
        return Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * .9,
            child: ListView.separated(itemBuilder: (context, index) {
              return AttemptRowWidget(attemptIndex: index,);
            }, separatorBuilder: (context, index) {
              return const SizedBox(height: 10,);
            }, itemCount: state.attemptsCount ?? 0,shrinkWrap: true,),
          ),
        );
      },
    );
  }
}
