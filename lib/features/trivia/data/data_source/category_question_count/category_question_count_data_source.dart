import 'package:trivia_riverpod/features/trivia/data/dto/category_question_count_dto.dart';

abstract class CategoryQuestionCountDataSource {
  Future<CategoryQuestionCountDto> getQuestionCountForCategory(int categoryId);
}
