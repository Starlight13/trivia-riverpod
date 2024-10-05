import 'package:trivia_riverpod/features/trivia/domain/models/trivia_config_model.dart';
import 'package:trivia_riverpod/shared/domain/models/trivia_question/trivia_question.dart';

abstract class TriviaRepository {
  Future<List<TriviaQuestion>> getTrivia({
    required int amount,
    required TriviaConfigModel config,
  });
}
