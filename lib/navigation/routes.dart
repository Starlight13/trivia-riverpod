import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:trivia_riverpod/screens/results/results_screen.dart';
import 'package:trivia_riverpod/screens/trivia/trivia_screen.dart';
import 'package:trivia_riverpod/screens/trivia_configuration/trivia_configuration_screen.dart';

part 'routes.g.dart';

@TypedGoRoute<TriviaConfigurationRoute>(
  path: '/',
  routes: [
    TypedGoRoute<TriviaRoute>(
      path: 'trivia',
      routes: [
        TypedGoRoute<ResultsRoute>(path: 'results'),
      ],
    ),
  ],
)
class TriviaConfigurationRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const TriviaConfigurationScreen();
}

class TriviaRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const TriviaScreen();
}

class ResultsRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ResultsScreen();
}

final goRouter = GoRouter(routes: $appRoutes);
