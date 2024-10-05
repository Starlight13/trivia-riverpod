import 'package:freezed_annotation/freezed_annotation.dart';

part 'question_category_model.freezed.dart';
part 'question_category_model.g.dart';

@freezed
class QuestionCategoryModel with _$QuestionCategoryModel {
  const factory QuestionCategoryModel({
    required int id,
    required String name,
  }) = _QuestionCategoryModel;

  factory QuestionCategoryModel.fromJson(Map<String, Object?> json) =>
      _$QuestionCategoryModelFromJson(json);
}
