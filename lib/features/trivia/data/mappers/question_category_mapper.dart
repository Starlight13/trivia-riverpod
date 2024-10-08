import 'package:trivia_riverpod/features/trivia/data/dto/question_category_dto.dart';
import 'package:trivia_riverpod/features/trivia/domain/models/question_category_model.dart';

class QuestionCategoryMapper {
  QuestionCategoryMapper._();

  static QuestionCategoryModel toModel(QuestionCategoryDto dto) {
    return QuestionCategoryModel(
      id: dto.id,
      name: dto.name,
    );
  }
}
