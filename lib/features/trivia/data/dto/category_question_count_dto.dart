import 'package:freezed_annotation/freezed_annotation.dart';

part 'category_question_count_dto.freezed.dart';
part 'category_question_count_dto.g.dart';

@freezed
class CategoryQuestionCountDto with _$CategoryQuestionCountDto {
  factory CategoryQuestionCountDto({
    required int totalQuestionCount,
    required int totalEasyQuestionCount,
    required int totalMediumQuestionCount,
    required int totalHardQuestionCount,
  }) = _CategoryQuestionCountDto;

  CategoryQuestionCountDto._();

  factory CategoryQuestionCountDto.fromJson(Map<String, dynamic> json) =>
      _$CategoryQuestionCountDtoFromJson(json);
}
