import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trivia_riverpod/models/trivia_config/trivia_config.dart';
import 'package:trivia_riverpod/providers/trivia_provider.dart';

class TriviaScreen extends ConsumerWidget {
  final TriviaConfig config;

  const TriviaScreen({super.key, required this.config});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final question = ref.watch(currentQuestionProvider(config));
    return Scaffold(
      appBar: AppBar(title: const Text('Trivia')),
      body: switch (question) {
        AsyncData(:final value) => value == null
            ? const Text('null')
            : Column(
                children: [
                  Text(value.question),
                  ...value.shuffledAnswers.map(
                    (answer) => ElevatedButton(
                      onPressed: () {
                        ref
                            .read(currentTriviaProvider(config).notifier)
                            .answerQuestion(value, answer);
                      },
                      child: Text(answer),
                    ),
                  ),
                ],
              ),
        AsyncError(:final error) => Text(error.toString()),
        _ => const Center(
            child: CircularProgressIndicator(),
          )
      },
    );
  }
}
