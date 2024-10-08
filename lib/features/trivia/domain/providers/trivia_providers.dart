import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:trivia_riverpod/features/trivia/data/data_source/trivia_questions/trivia_questions_data_source.dart';
import 'package:trivia_riverpod/features/trivia/data/data_source/trivia_questions/trivia_questions_remote_data_source.dart';
import 'package:trivia_riverpod/features/trivia/data/repositories/trivia_repository.dart';
import 'package:trivia_riverpod/features/trivia/domain/repositories/trivia_repository.dart';
import 'package:trivia_riverpod/features/trivia/domain/use_cases/get_trivia_use_case.dart';
import 'package:trivia_riverpod/shared/data/remote/network_service.dart';
import 'package:trivia_riverpod/shared/domain/providers/network_service_provider.dart';

part 'trivia_providers.g.dart';

@riverpod
TriviaQuestionsDataSource triviaDataSource(
  TriviaDataSourceRef ref, {
  required NetworkService networkService,
}) {
  return TriviaQuestionsRemoteDataSource(networkService: networkService);
}

@riverpod
TriviaRepository triviaRepository(TriviaRepositoryRef ref) {
  final networkService = ref.watch(networkServiceProvider);
  final dataSource = ref.watch(
    triviaDataSourceProvider(networkService: networkService),
  );
  return TriviaRepositoryImpl(triviaDataSource: dataSource);
}

@riverpod
GetTriviaUseCase getTriviaUseCase(GetTriviaUseCaseRef ref) {
  final repository = ref.watch(triviaRepositoryProvider);
  return GetTriviaUseCase(repository);
}
