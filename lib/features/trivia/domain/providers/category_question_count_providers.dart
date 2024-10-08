import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:trivia_riverpod/features/trivia/data/data_source/category_question_count/category_question_count_data_source.dart';
import 'package:trivia_riverpod/features/trivia/data/data_source/category_question_count/category_question_count_remote_data_source.dart';
import 'package:trivia_riverpod/features/trivia/data/repositories/category_question_count_repository.dart';
import 'package:trivia_riverpod/features/trivia/domain/repositories/category_question_count_repository.dart';
import 'package:trivia_riverpod/features/trivia/domain/use_cases/get_category_question_count_for_difficulty_use_case.dart';
import 'package:trivia_riverpod/features/trivia/domain/use_cases/get_category_question_count_use_case.dart';
import 'package:trivia_riverpod/features/trivia/domain/use_cases/get_max_question_count_use_case.dart';
import 'package:trivia_riverpod/shared/data/remote/network_service.dart';
import 'package:trivia_riverpod/shared/domain/providers/network_service_provider.dart';

part 'category_question_count_providers.g.dart';

@riverpod
CategoryQuestionCountDataSource categoryQuestionCountDataSource(
  CategoryQuestionCountDataSourceRef ref, {
  required NetworkService networkService,
}) {
  return CategoryQuestionCountRemoteDataSource(networkService: networkService);
}

@riverpod
CategoryQuestionCountRepository categoryQuestionCountRepository(
  CategoryQuestionCountRepositoryRef ref,
) {
  final networkService = ref.watch(networkServiceProvider);
  final dataSource = ref.watch(
    categoryQuestionCountDataSourceProvider(networkService: networkService),
  );
  return CategoryQuestionCountRepositoryImpl(dataSource: dataSource);
}

@riverpod
GetCategoryQuestionCountUseCase getCategoryQuestionCountUseCase(
  GetCategoryQuestionCountUseCaseRef ref,
) {
  final repository = ref.watch(categoryQuestionCountRepositoryProvider);
  return GetCategoryQuestionCountUseCase(repository: repository);
}

@riverpod
GetCategoryQuestionCountForDifficultyUseCase
    getCategoryQuestionCountForDifficultyUseCase(
  GetCategoryQuestionCountForDifficultyUseCaseRef ref,
) {
  return const GetCategoryQuestionCountForDifficultyUseCase();
}

@riverpod
GetMaxQuestionCountUseCase getMaxQuestionCountUseCase(
  GetMaxQuestionCountUseCaseRef ref,
) {
  return const GetMaxQuestionCountUseCase();
}
