import 'package:go_router/go_router.dart';
import 'package:guess_it_frontend/features/game/presentation/page/game_page.dart';
import 'package:guess_it_frontend/features/home/presentation/home_page.dart';

class AppRouter {
  static var router = GoRouter(initialLocation: HomePage.route, routes: [
    GoRoute(
        path: HomePage.route,
        builder: (context, state) {
          return const HomePage();
        }),
    GoRoute(
        path: '/game',
        builder: (context, state) {
          return GamePage(
            attemptsCount:
                int.parse(state.uri.queryParameters['attemptsCount'] ?? ''),
            wordLength:
                int.parse(state.uri.queryParameters['wordLength'] ?? ''),
          );
        })
  ]);
}
