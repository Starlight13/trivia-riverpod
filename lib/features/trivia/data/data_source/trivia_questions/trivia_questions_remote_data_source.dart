import 'package:trivia_riverpod/features/trivia/data/data_source/trivia_questions/trivia_questions_data_source.dart';
import 'package:trivia_riverpod/features/trivia/data/dto/trivia_question_dto.dart';
import 'package:trivia_riverpod/shared/data/remote/network_service.dart';

class TriviaQuestionsRemoteDataSource implements TriviaQuestionsDataSource {
  final NetworkService networkService;

  TriviaQuestionsRemoteDataSource({required this.networkService});

  @override
  Future<List<TriviaQuestionDto>> getTrivia({
    required int amount,
    required int? category,
    required String? difficulty,
  }) async {
    final response = await networkService.get(
      '/api.php',
      queryParameters: {
        'amount': amount,
        'category': category,
        'difficulty': difficulty,
        'encode': 'url3986',
      },
    );

    final questions = response.data['results'] as List;

    return questions.map((e) => TriviaQuestionDto.fromJson((e))).toList();
  }
}
