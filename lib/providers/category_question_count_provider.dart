import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:trivia_riverpod/models/category_question_count/category_question_count_model.dart';
import 'package:trivia_riverpod/models/trivia_question/trivia_question.dart';
import 'package:trivia_riverpod/service/network_service.dart';
import 'package:trivia_riverpod/service/service_locator.dart';

part 'category_question_count_provider.g.dart';

@riverpod
Future<CategoryQuestionCountModel> categoryQuestionCount(
  CategoryQuestionCountRef ref,
  int categoryId,
) async {
  return serviceLocator
      .get<NetworkService>()
      .getCategoryQuestionCount(categoryId);
}

@riverpod
FutureOr<int> categoryDifficultyQuestionCount(
  CategoryDifficultyQuestionCountRef ref,
  int categoryId,
  QuestionDifficulty? difficulty,
) async {
  final questionCount = await ref.watch(
    categoryQuestionCountProvider(categoryId).future,
  );
  return questionCount.getCountForDifficulty(difficulty);
}
