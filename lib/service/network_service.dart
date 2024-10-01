import 'package:dio/dio.dart';
import 'package:trivia_riverpod/env/env.dart';
import 'package:trivia_riverpod/models/category_question_count/category_question_count_model.dart';
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

  Future<CategoryQuestionCountModel> getCategoryQuestionCount(
    int categoryId,
  ) async {
    final response = await dio.get(
      '/api_count.php',
      queryParameters: {
        'category': categoryId,
      },
    );
    return CategoryQuestionCountModel.fromJson(
      response.data['category_question_count'],
    );
  }

  Future<List<TriviaQuestion>> getTrivia({
    required TriviaConfigModel config,
    int numberOfQuestions = 10,
  }) async {
    final response = await dio.get(
      '/api.php',
      queryParameters: {
        'amount': numberOfQuestions,
        ...config.toJson(),
        'encode': 'url3986',
      },
    );
    final questions = response.data['results'] as List;
    return questions.map((e) => TriviaQuestion.fromJson((e))).toList();
  }
}
