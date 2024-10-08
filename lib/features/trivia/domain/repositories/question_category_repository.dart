import 'package:trivia_riverpod/features/trivia/domain/models/question_category_model.dart';

abstract class QuestionCategoryRepository {
  Future<List<QuestionCategoryModel>> getCategories();
}
