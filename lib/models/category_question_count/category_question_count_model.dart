import 'dart:math';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:trivia_riverpod/models/trivia_question/trivia_question.dart';

part 'category_question_count_model.freezed.dart';
part 'category_question_count_model.g.dart';

@freezed
class CategoryQuestionCountModel with _$CategoryQuestionCountModel {
  factory CategoryQuestionCountModel({
    required int totalQuestionCount,
    required int totalEasyQuestionCount,
    required int totalMediumQuestionCount,
    required int totalHardQuestionCount,
  }) = _CategoryQuestionCount;

  CategoryQuestionCountModel._();

  int getCountForDifficulty(QuestionDifficulty? difficulty) => min(
        (switch (difficulty) {
                      QuestionDifficulty.easy => totalEasyQuestionCount,
                      QuestionDifficulty.medium => totalMediumQuestionCount,
                      QuestionDifficulty.hard => totalHardQuestionCount,
                      null => totalQuestionCount,
                    } /
                    5)
                .floor() *
            5,
        50,
      );

  factory CategoryQuestionCountModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryQuestionCountModelFromJson(json);
}
