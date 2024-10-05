import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:trivia_riverpod/shared/domain/models/trivia_question/trivia_question.dart';

part 'trivia_question_dto.freezed.dart';
part 'trivia_question_dto.g.dart';

@freezed
class TriviaQuestionDto with _$TriviaQuestionDto {
  factory TriviaQuestionDto({
    required String category,
    required QuestionType type,
    required QuestionDifficulty difficulty,
    required String question,
    required String correctAnswer,
    required List<String> incorrectAnswers,
  }) = _TriviaQuestionDto;

  factory TriviaQuestionDto.fromJson(Map<String, dynamic> json) =>
      _$TriviaQuestionDtoFromJson(json);
}
