import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:trivia_riverpod/models/trivia_config/trivia_config_model.dart';
import 'package:trivia_riverpod/models/trivia_question/trivia_question.dart';

part 'trivia_config_provider.g.dart';

@riverpod
class TriviaConfig extends _$TriviaConfig {
  @override
  TriviaConfigModel build() {
    return TriviaConfigModel(category: null, difficulty: null, type: null);
  }

  void updateCategory(int categoryId) {
    state = state.copyWith(category: categoryId);
  }

  void updateDifficulty(QuestionDifficulty difficulty) {
    state = state.copyWith(difficulty: difficulty);
  }

  void updateType(QuestionType type) {
    state = state.copyWith(type: type);
  }
}
