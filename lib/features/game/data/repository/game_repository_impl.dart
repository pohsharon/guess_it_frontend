import 'package:dio/dio.dart';
import 'package:guess_it_frontend/core/failure/failure.dart';
import 'package:guess_it_frontend/core/model/either.dart';
import 'package:guess_it_frontend/features/game/data/datasource/game_remote_datasource.dart';
import 'package:guess_it_frontend/features/game/domain/game_repository.dart';

class GameRepositoryImpl implements GameRepository {
  final GameRemoteDatasource gameRemoteDatasource;

  GameRepositoryImpl({required this.gameRemoteDatasource});

  @override
  Future<Either<Failure, void>> checkWord(String word) async {
    try {
      var result = await gameRemoteDatasource.checkWord(word);
      return Right(null);
    } on DioException {
      return Left(GameFailure(message: 'Please enter a valid word'));
    } catch (e) {
      return Left(GameFailure(message: 'Please enter a valid word'));
    }
  }

  @override
  Future<Either<Failure, String>> getRandomWord(int length) async {
    try {
      var result = await gameRemoteDatasource.getRandomWord(length);
      try {
        await gameRemoteDatasource.checkWord(result);
      } catch (e) {
        return getRandomWord(length);
      }
      return Right(result);
    } catch (e) {
      return Left(GameFailure(message: 'Error'));
    }
  }

  @override
  Future<Either<Failure, String?>> wordMeaning(String word) async {
    try {
      var result = await gameRemoteDatasource.wordMeaning(word);
      return Right(result);
    } catch (e) {
      return Left(GameFailure(message: 'Error fetching word meaning'));
    }
  }
}
