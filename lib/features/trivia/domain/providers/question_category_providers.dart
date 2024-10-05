import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:trivia_riverpod/features/trivia/data/data_source/question_category_data_source.dart';
import 'package:trivia_riverpod/features/trivia/data/data_source/question_category_remote_data_source.dart';
import 'package:trivia_riverpod/features/trivia/data/repositories/question_category_repository.dart';
import 'package:trivia_riverpod/features/trivia/domain/repositories/question_category_repository.dart';
import 'package:trivia_riverpod/features/trivia/domain/use_cases/get_question_categories_use_case.dart';
import 'package:trivia_riverpod/shared/data/remote/network_service.dart';
import 'package:trivia_riverpod/shared/domain/providers/network_service_provider.dart';

part 'question_category_providers.g.dart';

@riverpod
QuestionCategoryDataSource questionCategoryDataSource(
  QuestionCategoryDataSourceRef ref, {
  required NetworkService networkService,
}) {
  return QuestionCategoryRemoteDataSource(networkService: networkService);
}

@riverpod
QuestionCategoryRepository questionCategoryRepository(
  QuestionCategoryRepositoryRef ref,
) {
  final networkService = ref.watch(networkServiceProvider);
  final dataSource = ref.watch(
    questionCategoryDataSourceProvider(networkService: networkService),
  );
  return QuestionCategoryRepositoryImpl(dataSource: dataSource);
}

@riverpod
GetQuestionCategoriesUseCase getQuestionCategoriesUseCase(
  GetQuestionCategoriesUseCaseRef ref,
) {
  final repository = ref.watch(questionCategoryRepositoryProvider);
  return GetQuestionCategoriesUseCase(repository: repository);
}
