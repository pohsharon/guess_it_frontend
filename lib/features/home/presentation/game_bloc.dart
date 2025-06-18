import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spelling_bee/features/home/presentation/bloc/game_event.dart';
import 'package:spelling_bee/features/home/presentation/bloc/game_state.dart';

import 'dart:async';

class GameBloc extends Bloc<GameEvent, GameState>{
  GameBloc() : super(GameState.initial()) {
    on<StartGameEvent>(onStartGameEvent);
    }

  Future onStartGameEvent(StartGameEvent event, Emitter<GameState> emit) async {
    emit(state.copyWith(
      status: GameStatus.inProgress,
      word: "TEST",
      attemptsCount: event.attemptsCount,
    ));
}
}