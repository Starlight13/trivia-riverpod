import 'package:trivia_riverpod/features/trivia/data/data_source/category_question_count/category_question_count_data_source.dart';
import 'package:trivia_riverpod/features/trivia/data/mappers/category_question_count_mapper.dart';
import 'package:trivia_riverpod/features/trivia/domain/models/category_question_count_model.dart';
import 'package:trivia_riverpod/features/trivia/domain/repositories/category_question_count_repository.dart';

class CategoryQuestionCountRepositoryImpl
    implements CategoryQuestionCountRepository {
  final CategoryQuestionCountDataSource dataSource;

  CategoryQuestionCountRepositoryImpl({required this.dataSource});

  @override
  Future<CategoryQuestionCountModel> getQuestionCountForCategory(
    int categoryId,
  ) async {
    final dto = await dataSource.getQuestionCountForCategory(categoryId);
    return CategoryQuestionCountMapper.toModel(dto);
  }
}
