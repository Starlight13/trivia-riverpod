import 'package:dio/dio.dart';
import 'package:trivia_riverpod/env/env.dart';
import 'package:trivia_riverpod/models/question_category/question_category.dart';
import 'package:trivia_riverpod/models/trivia_config/trivia_config_model.dart';
import 'package:trivia_riverpod/models/trivia_question/trivia_question.dart';

class NetworkService {
  final dio = Dio(BaseOptions(baseUrl: Env.baseUrl));

  Future<List<QuestionCategory>> getCategories() async {
    final response = await dio.get('/api_category.php');
    final categories = response.data['trivia_categories'] as List;
    return categories.map((e) => QuestionCategory.fromJson(e)).toList();
  }

  Future<List<TriviaQuestion>> getTrivia({
    required TriviaConfigModel config,
  }) async {
    final response = await dio.get(
      '/api.php',
      queryParameters: {
        ...config.toJson(),
        'encode': 'url3986',
      },
    );
    final questions = response.data['results'] as List;
    return questions.map((e) => TriviaQuestion.fromJson((e))).toList();
  }
}
