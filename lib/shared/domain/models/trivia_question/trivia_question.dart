import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'trivia_question.freezed.dart';

@freezed
class TriviaQuestion with _$TriviaQuestion {
  factory TriviaQuestion({
    required QuestionType type,
    required QuestionDifficulty difficulty,
    required String category,
    required String question,
    required String correctAnswer,
    required List<String> answers,
  }) = _TriviaQuestion;

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
