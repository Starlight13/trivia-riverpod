import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:trivia_riverpod/features/trivia/domain/models/trivia_question_model.dart';
import 'package:trivia_riverpod/shared/utils/uri_string_converter.dart';

part 'trivia_question_dto.freezed.dart';

part 'trivia_question_dto.g.dart';

@freezed
class TriviaQuestionDto with _$TriviaQuestionDto {
  @UriStringConverter()
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
