import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trivia_riverpod/models/trivia_config/trivia_config.dart';
import 'package:trivia_riverpod/providers/trivia_provider.dart';

class ResultsScreen extends ConsumerWidget {
  final TriviaConfig config;
  const ResultsScreen({
    super.key,
    required this.config,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final correct = ref.watch(correctlyAnsweredQuestionsCountProvider(config));
    final total = ref.watch(questionsCountProvider(config));
    final questions = ref.watch(currentTriviaProvider(config));
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    backgroundColor: theme.scaffoldBackgroundColor,
                    scrolledUnderElevation: 0,
                    elevation: 0,
                    flexibleSpace: Center(
                      child: Text(
                        '$correct/$total',
                        style: theme.textTheme.displayLarge,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    collapsedHeight: 80,
                    expandedHeight: 200,
                    snap: true,
                    floating: true,
                    pinned: true,
                  ),
                  switch (questions) {
                    AsyncData(:final value) => SliverList.builder(
                        itemCount: value.length,
                        itemBuilder: (context, index) {
                          final question = value[index];
                          return ListTile(
                            title: Text(question.question),
                            subtitle: Text(question.givenAnswer ?? ''),
                            trailing: Icon(
                              question.isCorrect ? Icons.check : Icons.close,
                              color: question.isCorrect
                                  ? Colors.green
                                  : Colors.red,
                            ),
                          );
                        },
                      ),
                    _ => const SliverFillRemaining(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                  },
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: OutlinedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Back'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
