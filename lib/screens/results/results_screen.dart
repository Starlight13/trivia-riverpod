import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trivia_riverpod/features/trivia/domain/models/trivia_model.dart';
import 'package:trivia_riverpod/features/trivia/presentation/providers/selected_question_count_notifier.dart';
import 'package:trivia_riverpod/features/trivia/presentation/providers/trivia_config_notifier.dart';
import 'package:trivia_riverpod/features/trivia/presentation/providers/trivia_notifier.dart';
import 'package:trivia_riverpod/navigation/routes.dart';

class ResultsScreen extends ConsumerWidget {
  const ResultsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final triviaConfig = ref.watch(triviaConfigNotifierProvider);
    final amount = ref.watch(selectedQuestionCountNotifierProvider);
    final trivia = ref.watch(triviaNotifierProvider(amount, triviaConfig));

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
          SliverList.builder(
            itemCount: questions.length,
            itemBuilder: (context, index) {
              final question = questions[index];
              final givenAnswer = triviaModel.getGivenAnswer(question);
              final isCorrect =
                  triviaModel.getIsQuestionCorrectlyAnswered(question);
              return ListTile(
                title: Text(question.question),
                subtitle: Text(givenAnswer ?? ''),
                trailing: Icon(
                  isCorrect ? Icons.check : Icons.close,
                  color: isCorrect ? Colors.green : Colors.red,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
