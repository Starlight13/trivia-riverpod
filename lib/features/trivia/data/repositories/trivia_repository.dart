import 'package:trivia_riverpod/features/trivia/data/data_source/trivia_questions/trivia_questions_data_source.dart';
import 'package:trivia_riverpod/features/trivia/data/mappers/trivia_question_mapper.dart';
import 'package:trivia_riverpod/features/trivia/domain/repositories/trivia_repository.dart';
import 'package:trivia_riverpod/features/trivia/domain/models/trivia_config_model.dart';
import 'package:trivia_riverpod/features/trivia/domain/models/trivia_question_model.dart';

class TriviaRepositoryImpl implements TriviaRepository {
  final TriviaQuestionsDataSource triviaDataSource;

  TriviaRepositoryImpl({required this.triviaDataSource});

  @override
  Future<List<TriviaQuestionModel>> getTrivia({
    required int amount,
    required TriviaConfigModel config,
  }) async {
    return triviaDataSource
        .getTrivia(
          amount: amount,
          category: config.category,
          difficulty: config.difficulty?.name,
        )
        .then((dtos) => dtos.map(TriviaQuestionMapper.toModel).toList());
  }
}
