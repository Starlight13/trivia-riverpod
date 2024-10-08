import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:trivia_riverpod/features/trivia/domain/models/question_category_model.dart';
import 'package:trivia_riverpod/features/trivia/domain/providers/question_category_providers.dart';

part 'question_categories_provider.g.dart';

@riverpod
FutureOr<List<QuestionCategoryModel>> questionCategories(
  QuestionCategoriesRef ref,
) {
  final getQuestionCategoriesUseCase =
      ref.read(getQuestionCategoriesUseCaseProvider);
  return getQuestionCategoriesUseCase.call();
}
