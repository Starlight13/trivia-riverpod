import 'package:trivia_riverpod/features/trivia/data/dto/category_question_count_dto.dart';
import 'package:trivia_riverpod/features/trivia/domain/models/category_question_count_model.dart';

class CategoryQuestionCountMapper {
  CategoryQuestionCountMapper._();

  static CategoryQuestionCountDto fromModel(CategoryQuestionCountModel model) {
    return CategoryQuestionCountDto(
      totalQuestionCount: model.totalQuestionCount,
      totalEasyQuestionCount: model.totalEasyQuestionCount,
      totalMediumQuestionCount: model.totalMediumQuestionCount,
      totalHardQuestionCount: model.totalHardQuestionCount,
    );
  }

  static CategoryQuestionCountModel toModel(CategoryQuestionCountDto dto) {
    return CategoryQuestionCountModel(
      totalQuestionCount: dto.totalQuestionCount,
      totalEasyQuestionCount: dto.totalEasyQuestionCount,
      totalMediumQuestionCount: dto.totalMediumQuestionCount,
      totalHardQuestionCount: dto.totalHardQuestionCount,
    );
  }
}
