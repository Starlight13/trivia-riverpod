import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:trivia_riverpod/shared/utils/uri_string_converter.dart';

part 'trivia_question.freezed.dart';
part 'trivia_question.g.dart';

@freezed
class TriviaQuestion with _$TriviaQuestion {
  @UriStringConverter()
  factory TriviaQuestion({
    required QuestionType type,
    required QuestionDifficulty difficulty,
    required String category,
    required String question,
    required String correctAnswer,
    required List<String> answers,
  }) = _TriviaQuestion;

  factory TriviaQuestion.fromJson(Map<String, dynamic> json) =>
      _$TriviaQuestionFromJson(json);

  TriviaQuestion._();
}

enum QuestionType {
  multiple,
  boolean,
}

enum QuestionDifficulty {
  easy,
  medium,
  hard,
}
