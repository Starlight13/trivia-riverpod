import 'dart:math';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:trivia_riverpod/features/trivia/presentation/providers/category_question_count_providers.dart';

part 'selected_question_count_notifier.g.dart';

@riverpod
class SelectedQuestionCountNotifier extends _$SelectedQuestionCountNotifier {
  @override
  int build() {
    ref.listen(
      currentMaxQuestionCountProvider,
      (int? _, int next) => onMaxQuestionCountChanged(next),
    );
    return 10;
  }

  void onMaxQuestionCountChanged(int maxQuestionCount) {
    state = min(state, maxQuestionCount);
  }

  void updateNumberOfQuestions(int numberOfQuestions) {
    state = numberOfQuestions;
  }
}
