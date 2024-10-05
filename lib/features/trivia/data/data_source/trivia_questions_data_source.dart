import 'package:trivia_riverpod/features/trivia/data/dto/trivia_question_dto.dart';

abstract class TriviaQuestionsDataSource {
  Future<List<TriviaQuestionDto>> getTrivia({
    required int amount,
    required int? category,
    required String? difficulty,
  });
}
