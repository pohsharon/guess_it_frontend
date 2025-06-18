import 'package:flutter/material.dart';

class GamePage extends StatelessWidget {
  final String wordLength;
  final String attemptsCount;

  const GamePage({
    super.key,
    required this.wordLength,
    required this.attemptsCount,
  });

  static String route({required String wordLength, required String attemptsCount}) =>
      Uri(
        path: '/game',
        queryParameters: {
          'wordLength': wordLength.toString(),
          'attemptsCount': attemptsCount.toString(),
        },
      ).toString();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Game', style: Theme.of(context).textTheme.headlineMedium,),),
      body: Column(
        children: [SizedBox(height: 20,),
        ],
      ),
    );
  }
}
