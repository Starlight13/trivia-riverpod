import 'package:trivia_riverpod/features/trivia/domain/models/category_question_count_model.dart';
import 'package:trivia_riverpod/features/trivia/domain/models/trivia_question_model.dart';

class GetCategoryQuestionCountForDifficultyUseCase {
  const GetCategoryQuestionCountForDifficultyUseCase();

  int call({
    required CategoryQuestionCountModel questionCountModel,
    required QuestionDifficulty? difficulty,
  }) =>
      switch (difficulty) {
        QuestionDifficulty.easy => questionCountModel.totalEasyQuestionCount,
        QuestionDifficulty.medium =>
          questionCountModel.totalMediumQuestionCount,
        QuestionDifficulty.hard => questionCountModel.totalHardQuestionCount,
        null => questionCountModel.totalQuestionCount,
      };
}
