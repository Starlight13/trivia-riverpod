import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trivia_riverpod/models/trivia_question/trivia_question.dart';
import 'package:trivia_riverpod/navigation/routes.dart';
import 'package:trivia_riverpod/providers/trivia_provider.dart';
import 'package:trivia_riverpod/screens/trivia/widgets/answer_button.dart';

class TriviaScreen extends ConsumerWidget {
  const TriviaScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final questions = ref.watch(currentTriviaProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Trivia')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: switch (questions) {
            AsyncData(:final value) => _TriviaPageView(
                questions: value,
                onGiveAnswer: (q, a) => ref
                    .read(currentTriviaProvider.notifier)
                    .answerQuestion(q, a),
                onSeeResults: () => ResultsRoute().go(context),
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
  final IList<TriviaQuestion> questions;
  final Function(TriviaQuestion question, String answer) onGiveAnswer;

  const _TriviaPageView({
    required this.questions,
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
    return PageView.builder(
      controller: _pageController,
      itemCount: widget.questions.length,
      itemBuilder: (context, index) {
        final question = widget.questions[index];
        final isLast = index == widget.questions.length - 1;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    textAlign: TextAlign.center,
                    question.question,
                    style: const TextStyle(fontSize: 24),
                  ),
                ),
              ),
              ...question.shuffledAnswers.map((answer) {
                return AnswerButton(
                  isSelected: question.givenAnswer == answer,
                  caption: answer,
                  isCorrect: question.correctAnswer == answer,
                  onTap: question.isAnswered
                      ? null
                      : () => widget.onGiveAnswer(question, answer),
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
