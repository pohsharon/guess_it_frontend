import 'package:get_it/get_it.dart';
import 'package:guess_it_frontend/core/api/dio_client.dart';
import 'package:guess_it_frontend/features/game/data/datasource/game_remote_datasource.dart';
import 'package:guess_it_frontend/features/game/data/repository/game_repository_impl.dart';
import 'package:guess_it_frontend/features/game/domain/game_repository.dart';
import 'package:guess_it_frontend/features/game/presentation/bloc/game_bloc.dart';

var getIt = GetIt.instance;

void setup(){
  registerDatasources();
  registerRepositories();
  registerBloc();
}
void registerDatasources(){
  getIt.registerSingleton(GameRemoteDatasource(dio: DioClient.getDio()));
}
void registerRepositories(){
  getIt.registerSingleton<GameRepository>(GameRepositoryImpl(gameRemoteDatasource: getIt()));
}
void registerBloc(){
  getIt.registerFactory<GameBloc>(() => GameBloc(gameRepository: getIt()));
}