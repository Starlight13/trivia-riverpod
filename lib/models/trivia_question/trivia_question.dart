import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:trivia_riverpod/models/uri_string_converter.dart';

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
    required List<String> incorrectAnswers,
    String? givenAnswer,
  }) = _TriviaQuestion;

  List<String> get shuffledAnswers => switch (type) {
        QuestionType.multiple => [...incorrectAnswers, correctAnswer]
          ..shuffle(Random(correctAnswer.hashCode)),
        QuestionType.boolean => ['True', 'False'],
      };

  factory TriviaQuestion.fromJson(Map<String, dynamic> json) =>
      _$TriviaQuestionFromJson(json);

  TriviaQuestion._();

  bool get isAnswered => givenAnswer != null;

  bool get isCorrect => givenAnswer == correctAnswer;
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
