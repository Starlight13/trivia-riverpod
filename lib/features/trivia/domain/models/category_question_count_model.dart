import 'package:freezed_annotation/freezed_annotation.dart';

part 'category_question_count_model.freezed.dart';

@freezed
class CategoryQuestionCountModel with _$CategoryQuestionCountModel {
  factory CategoryQuestionCountModel({
    required int totalQuestionCount,
    required int totalEasyQuestionCount,
    required int totalMediumQuestionCount,
    required int totalHardQuestionCount,
  }) = _CategoryQuestionCountModel;

  CategoryQuestionCountModel._();
}
