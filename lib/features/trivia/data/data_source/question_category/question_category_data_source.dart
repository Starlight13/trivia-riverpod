import 'package:trivia_riverpod/features/trivia/data/dto/question_category_dto.dart';

abstract class QuestionCategoryDataSource {
  Future<List<QuestionCategoryDto>> getQuestionCategories();
}
