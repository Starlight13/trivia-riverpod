import 'package:trivia_riverpod/features/trivia/domain/models/category_question_count_model.dart';

abstract class CategoryQuestionCountRepository {
  Future<CategoryQuestionCountModel> getQuestionCountForCategory(
    int categoryId,
  );
}
