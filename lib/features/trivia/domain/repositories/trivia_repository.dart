import 'package:trivia_riverpod/features/trivia/domain/models/trivia_config_model.dart';
import 'package:trivia_riverpod/features/trivia/domain/models/trivia_question_model.dart';

abstract class TriviaRepository {
  Future<List<TriviaQuestionModel>> getTrivia({
    required int amount,
    required TriviaConfigModel config,
  });
}
