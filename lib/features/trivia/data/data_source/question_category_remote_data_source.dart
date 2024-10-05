import 'package:trivia_riverpod/features/trivia/data/data_source/question_category_data_source.dart';
import 'package:trivia_riverpod/features/trivia/data/dto/question_category_dto.dart';
import 'package:trivia_riverpod/shared/data/remote/network_service.dart';

class QuestionCategoryRemoteDataSource implements QuestionCategoryDataSource {
  final NetworkService networkService;

  QuestionCategoryRemoteDataSource({required this.networkService});

  @override
  Future<List<QuestionCategoryDto>> getQuestionCategories() async {
    final response = await networkService.get('/api_category.php');
    final categories = response.data['trivia_categories'] as List;
    return categories.map((e) => QuestionCategoryDto.fromJson(e)).toList();
  }
}
