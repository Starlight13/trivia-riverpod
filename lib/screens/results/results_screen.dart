import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trivia_riverpod/features/trivia/domain/models/trivia_model.dart';
import 'package:trivia_riverpod/features/trivia/presentation/providers/trivia_notifier.dart';
import 'package:trivia_riverpod/navigation/routes.dart';

class ResultsScreen extends ConsumerWidget {
  const ResultsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trivia = ref.watch(currentTriviaNotifierProvider);

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            switch (trivia) {
              AsyncData(:final value) => _ResultsScreen(triviaModel: value),
              _ => const CircularProgressIndicator(),
            },
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: OutlinedButton(
                onPressed: () => TriviaConfigurationRoute().go(context),
                child: const Text('Back'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ResultsScreen extends StatelessWidget {
  const _ResultsScreen({
    required this.triviaModel,
  });

  final TriviaModel triviaModel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final questions = triviaModel.questions;
    final correct = triviaModel.correctAnswerCount;
    final total = triviaModel.questionCount;
    return Expanded(
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: BackButton(
              onPressed: () => TriviaConfigurationRoute().go(context),
            ),
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
                      color: question.isCorrect ? Colors.green : Colors.red,
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
    );
  }
}
