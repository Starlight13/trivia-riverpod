import 'package:trivia_riverpod/features/trivia/domain/models/category_question_count_model.dart';
import 'package:trivia_riverpod/features/trivia/domain/repositories/category_question_count_repository.dart';

class GetCategoryQuestionCountUseCase {
  final CategoryQuestionCountRepository repository;

  GetCategoryQuestionCountUseCase({required this.repository});

  Future<CategoryQuestionCountModel> call({required int categoryId}) async {
    return repository.getQuestionCountForCategory(categoryId);
  }
}
