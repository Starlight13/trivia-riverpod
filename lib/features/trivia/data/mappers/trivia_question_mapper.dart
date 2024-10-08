import 'package:trivia_riverpod/features/trivia/data/dto/trivia_question_dto.dart';
import 'package:trivia_riverpod/shared/domain/models/trivia_question/trivia_question.dart';

class TriviaQuestionMapper {
  TriviaQuestionMapper._();

  static TriviaQuestion toModel(TriviaQuestionDto dto) {
    return TriviaQuestion(
      question: dto.question,
      category: dto.category,
      type: dto.type,
      difficulty: dto.difficulty,
      correctAnswer: dto.correctAnswer,
      answers: switch (dto.type) {
        QuestionType.multiple => [dto.correctAnswer, ...dto.incorrectAnswers]
          ..shuffle(),
        QuestionType.boolean => ['True', 'False'],
      },
    );
  }
}
