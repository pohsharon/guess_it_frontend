import 'package:dio/dio.dart';

class GameRemoteDatasource {
  final Dio dio;

  GameRemoteDatasource({required this.dio});

  Future<String> getRandomWord(int length) async {
    var result = await dio
        .get('https://random-word-api.herokuapp.com/word', queryParameters: {
      'length': length,
    });
    return (result.data as List).first;
  }

  Future checkWord(String word) async {
    var result =
        await dio.get('https://api.dictionaryapi.dev/api/v2/entries/en/$word');
    return;
  }

  Future<String?> wordMeaning(String word) async {
    try {
      final response = await dio
          .get('https://api.dictionaryapi.dev/api/v2/entries/en/$word');

      final data = response.data;

      if (data is List && data.isNotEmpty) {
        final firstEntry = data[0];
        final meanings = firstEntry['meanings'] as List?;
        if (meanings != null && meanings.isNotEmpty) {
          final definitions = meanings[0]['definitions'] as List?;
          if (definitions != null && definitions.isNotEmpty) {
            return definitions[0]['definition'] as String?;
          }
        }
      }
      return 'No definition found.';
    } catch (e) {
      print('Error fetching word meaning: $e');
      return 'Definition unavailable.';
    }
  }
}
