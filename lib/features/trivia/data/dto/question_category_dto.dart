import 'package:freezed_annotation/freezed_annotation.dart';

part 'question_category_dto.freezed.dart';
part 'question_category_dto.g.dart';

@freezed
class QuestionCategoryDto with _$QuestionCategoryDto {
  const factory QuestionCategoryDto({
    required int id,
    required String name,
  }) = _QuestionCategoryDto;

  factory QuestionCategoryDto.fromJson(Map<String, Object?> json) =>
      _$QuestionCategoryDtoFromJson(json);
}
