import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:trivia_riverpod/models/category_question_count/category_question_count_model.dart';
import 'package:trivia_riverpod/shared/domain/models/trivia_question/trivia_question.dart';
import 'package:trivia_riverpod/shared/domain/providers/dio_provider.dart';

part 'category_question_count_provider.g.dart';

@riverpod
Future<CategoryQuestionCountModel> categoryQuestionCount(
  CategoryQuestionCountRef ref,
  int categoryId,
) async {
  final response = await ref.watch(dioClientProvider).get(
    '/api_count.php',
    queryParameters: {
      'category': categoryId,
    },
  );
  return CategoryQuestionCountModel.fromJson(
    response.data['category_question_count'],
  );
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
