import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trivia_riverpod/extensions/string_extension.dart';
import 'package:trivia_riverpod/models/trivia_question/trivia_question.dart';
import 'package:trivia_riverpod/navigation/routes.dart';
import 'package:trivia_riverpod/providers/categories_provider.dart';
import 'package:trivia_riverpod/providers/selected_question_count_provider.dart';
import 'package:trivia_riverpod/providers/trivia_config_provider.dart';

class TriviaConfigurationScreen extends ConsumerWidget {
  const TriviaConfigurationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(categoriesProvider);
    final selectedCategory = ref.watch(selectedCategoryProvider);
    final selectedDifficulty = ref.watch(selectedDifficultyProvider);
    final numberOfQuestions = ref.watch(selectedQuestionCountProvider);
    final maxNumberOfQuestions = ref.watch(syncMaxQuestionCountProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Trivia Configuration')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        ('Category'),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      DropdownButtonFormField<int>(
                        value: selectedCategory,
                        items: [
                          const DropdownMenuItem(
                            value: null,
                            child: Text('Any Category'),
                          ),
                          ...categories.map(
                            data: (categories) => categories.value.map(
                              (category) {
                                return DropdownMenuItem(
                                  value: category.id,
                                  child: Text(category.name),
                                );
                              },
                            ),
                            error: (_) => [],
                            loading: (_) => [],
                          ),
                        ],
                        onChanged: (value) => ref
                            .read(triviaConfigProvider.notifier)
                            .updateCategory(value),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Difficulty',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      DropdownButtonFormField<QuestionDifficulty>(
                        value: selectedDifficulty,
                        items: [
                          const DropdownMenuItem(
                            value: null,
                            child: Text('Any Difficulty'),
                          ),
                          ...QuestionDifficulty.values.map(
                            (e) => DropdownMenuItem(
                              value: e,
                              child: Text(e.name.capitalized),
                            ),
                          ),
                        ],
                        onChanged: (value) => ref
                            .read(triviaConfigProvider.notifier)
                            .updateDifficulty(value),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Number of Questions',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        numberOfQuestions.toString(),
                        style: Theme.of(context).textTheme.displayLarge,
                        textAlign: TextAlign.center,
                      ),
                      Slider(
                        value: numberOfQuestions.toDouble(),
                        onChanged: (value) => ref
                            .read(selectedQuestionCountProvider.notifier)
                            .updateNumberOfQuestions(
                              value.toInt(),
                            ),
                        divisions: (maxNumberOfQuestions / 5).floor(),
                        max: maxNumberOfQuestions.toDouble(),
                      ),
                    ],
                  ),
                ),
              ),
              FloatingActionButton(
                onPressed: () => TriviaRoute().go(context),
                child: const Text('Start Trivia'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
