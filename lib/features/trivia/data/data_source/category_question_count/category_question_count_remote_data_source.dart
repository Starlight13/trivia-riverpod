import 'package:trivia_riverpod/features/trivia/data/data_source/category_question_count/category_question_count_data_source.dart';
import 'package:trivia_riverpod/features/trivia/data/dto/category_question_count_dto.dart';
import 'package:trivia_riverpod/shared/data/remote/network_service.dart';

class CategoryQuestionCountRemoteDataSource
    implements CategoryQuestionCountDataSource {
  final NetworkService networkService;

  CategoryQuestionCountRemoteDataSource({required this.networkService});

  @override
  Future<CategoryQuestionCountDto> getQuestionCountForCategory(
    int categoryId,
  ) async {
    final response = await networkService.get(
      '/api_count.php',
      queryParameters: {
        'category': categoryId,
      },
    );
    return CategoryQuestionCountDto.fromJson(
      response.data['category_question_count'],
    );
  }
}
