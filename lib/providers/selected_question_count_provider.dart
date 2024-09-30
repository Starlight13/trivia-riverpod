import 'dart:math';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:trivia_riverpod/providers/trivia_config_provider.dart';

part 'selected_question_count_provider.g.dart';

@riverpod
class SelectedQuestionCount extends _$SelectedQuestionCount {
  @override
  int build() {
    ref.listen(
      maxQuestionCountProvider,
      (AsyncValue<int>? _, AsyncValue<int> next) {
        onMaxQuestionCountChanged(next.value ?? 50);
      },
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
