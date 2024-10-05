import 'package:trivia_riverpod/features/trivia/domain/models/question_category_model.dart';
import 'package:trivia_riverpod/features/trivia/domain/repositories/question_category_repository.dart';

class GetQuestionCategoriesUseCase {
  final QuestionCategoryRepository repository;

  GetQuestionCategoriesUseCase({required this.repository});

  Future<List<QuestionCategoryModel>> call() async {
    return repository.getCategories();
  }
}
