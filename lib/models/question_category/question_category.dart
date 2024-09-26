import 'package:freezed_annotation/freezed_annotation.dart';

part 'question_category.freezed.dart';
part 'question_category.g.dart';

@freezed
class QuestionCategory with _$QuestionCategory {
  const factory QuestionCategory({
    required int id,
    required String name,
  }) = _Category;

  factory QuestionCategory.fromJson(Map<String, Object?> json) =>
      _$QuestionCategoryFromJson(json);
}
