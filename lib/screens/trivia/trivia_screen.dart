import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trivia_riverpod/models/trivia_config/trivia_config.dart';
import 'package:trivia_riverpod/models/trivia_question/trivia_question.dart';
import 'package:trivia_riverpod/providers/trivia_provider.dart';

class TriviaScreen extends ConsumerWidget {
  final TriviaConfig config;

  const TriviaScreen({super.key, required this.config});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final questions = ref.watch(currentTriviaProvider(config));
    return Scaffold(
      appBar: AppBar(title: const Text('Trivia')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: switch (questions) {
            AsyncData(:final value) => _TriviaPageView(
                questions: value,
                onGiveAnswer: (q, a) => ref
                    .read(currentTriviaProvider(config).notifier)
                    .answerQuestion(q, a),
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
  final IList<TriviaQuestion> questions;
  final Function(TriviaQuestion question, String answer) onGiveAnswer;

  const _TriviaPageView({
    required this.questions,
    required this.onGiveAnswer,
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
                return _AnswerButton(
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
                      icon: const Icon(
                        Icons.chevron_left,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: isLast
                        ? const OutlinedButton(
                            onPressed: null,
                            child: Text('Results'),
                          )
                        : OutlinedButton.icon(
                            onPressed: () => animateToPage(index + 1),
                            icon: isLast
                                ? null
                                : const Icon(
                                    Icons.chevron_right,
                                  ),
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

class _AnswerButton extends StatelessWidget {
  const _AnswerButton({
    required this.isSelected,
    required this.caption,
    this.onTap,
    required this.isCorrect,
  });

  final bool isSelected;
  final bool isCorrect;
  final String caption;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: isSelected
            ? WidgetStatePropertyAll(
                isCorrect ? Colors.green : Colors.red,
              )
            : isCorrect
                ? WidgetStatePropertyAll(
                    Colors.green.withOpacity(0.3),
                  )
                : null,
        foregroundColor: isSelected
            ? const WidgetStatePropertyAll(
                Colors.white,
              )
            : null,
      ),
      onPressed: onTap,
      child: Text(
        caption,
        style: TextStyle(
          color: isSelected ? Colors.white : null,
        ),
      ),
    );
  }
}
