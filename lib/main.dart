import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trivia_riverpod/models/trivia_config/trivia_config.dart';
import 'package:trivia_riverpod/providers/provider_observer.dart';
import 'package:trivia_riverpod/screens/trivia/trivia_screen.dart';
import 'package:trivia_riverpod/service/service_locator.dart';

void main() {
  setupServiceLocator();
  runApp(
    ProviderScope(
      observers: [
        LoggingProviderObserver(),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: TriviaScreen(
        config: TriviaConfig(
          amount: 10,
          category: null,
          difficulty: null,
          type: null,
        ),
      ),
    );
  }
}
