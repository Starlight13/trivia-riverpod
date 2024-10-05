import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trivia_riverpod/features/trivia/domain/models/trivia_model.dart';
import 'package:trivia_riverpod/features/trivia/presentation/providers/trivia_notifier.dart';
import 'package:trivia_riverpod/shared/domain/models/trivia_question/trivia_question.dart';
import 'package:trivia_riverpod/navigation/routes.dart';
import 'package:trivia_riverpod/features/trivia/presentation/screens/widgets/answer_button.dart';

class TriviaScreen extends ConsumerWidget {
  const TriviaScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final questions = ref.watch(currentTriviaNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trivia'),
        leading: BackButton(
          onPressed: () => showDialog(
            context: context,
            builder: (innerContext) => AlertDialog(
              actionsAlignment: MainAxisAlignment.spaceEvenly,
              title: const Text('Are you sure you want to exit?'),
              content: const Text(
                'All your current progress will be lost',
              ),
              actions: [
                TextButton(
                  onPressed: () => goRouter.pop(),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () => TriviaConfigurationRoute().go(context),
                  child: const Text('Exit'),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: switch (questions) {
            AsyncData(:final value) => _TriviaPageView(
                trivia: value,
                onGiveAnswer: (q, a) => ref
                    .read(currentTriviaNotifierProvider)
                    .recordResponse(q, a),
                onSeeResults: () => showDialog(
                  context: context,
                  builder: (innerContext) => AlertDialog(
                    actionsAlignment: MainAxisAlignment.spaceEvenly,
                    title:
                        const Text('Are you sure you want to end the trivia?'),
                    content: const Text(
                      'Some questions were left unanswered.',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => goRouter.pop(),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () => ResultsRoute().go(context),
                        child: const Text('End Trivia'),
                      ),
                    ],
                  ),
                ),
              ),
            AsyncError(:final error) => Text(error.toString()),
            _ => const Center(
                child: CircularProgressIndicator(),
              )
          },
        ),
      ),
    );
  }
}

class _TriviaPageView extends StatefulWidget {
  final Function() onSeeResults;
  final TriviaModel trivia;
  final Function(TriviaQuestion question, String answer) onGiveAnswer;

  const _TriviaPageView({
    required this.trivia,
    required this.onGiveAnswer,
    required this.onSeeResults,
  });

  @override
  State<_TriviaPageView> createState() => _TriviaPageViewState();
}

class _TriviaPageViewState extends State<_TriviaPageView> {
  final _pageController = PageController();

  void animateToPage(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    final trivia = widget.trivia;
    final questionCount = trivia.questionCount;
    return PageView.builder(
      controller: _pageController,
      itemCount: questionCount,
      itemBuilder: (context, index) {
        final questionAnswer =
            widget.trivia.questionAnswerMap.entries.elementAt(index);
        final isLast = index == questionCount - 1;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    textAlign: TextAlign.center,
                    questionAnswer.key.question,
                    style: const TextStyle(fontSize: 24),
                  ),
                ),
              ),
              ...questionAnswer.key.answers.map((answer) {
                return AnswerButton(
                  isSelected: questionAnswer.value == answer,
                  caption: answer,
                  isCorrect: questionAnswer.key.correctAnswer == answer,
                  onTap: trivia.getIsQuestionAnswered(questionAnswer.key)
                      ? null
                      : () => widget.onGiveAnswer(questionAnswer.key, answer),
                );
              }),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed:
                          index == 0 ? null : () => animateToPage(index - 1),
                      label: const Text('Previous'),
                      icon: const Icon(Icons.chevron_left),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: isLast
                        ? OutlinedButton(
                            onPressed: widget.onSeeResults,
                            child: const Text('Results'),
                          )
                        : OutlinedButton.icon(
                            onPressed: () => animateToPage(index + 1),
                            icon: const Icon(Icons.chevron_right),
                            label: const Text('Next'),
                            iconAlignment: IconAlignment.end,
                          ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
