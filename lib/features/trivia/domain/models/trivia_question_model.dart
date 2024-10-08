import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'trivia_question_model.freezed.dart';

@freezed
class TriviaQuestionModel with _$TriviaQuestionModel {
  factory TriviaQuestionModel({
    required QuestionType type,
    required QuestionDifficulty difficulty,
    required String category,
    required String question,
    required String correctAnswer,
    required List<String> answers,
  }) = _TriviaQuestionModel;

  TriviaQuestionModel._();
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
