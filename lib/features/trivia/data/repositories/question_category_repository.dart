import 'package:trivia_riverpod/features/trivia/data/data_source/question_category_data_source.dart';
import 'package:trivia_riverpod/features/trivia/data/mappers/question_category_mapper.dart';
import 'package:trivia_riverpod/features/trivia/domain/models/question_category_model.dart';
import 'package:trivia_riverpod/features/trivia/domain/repositories/question_category_repository.dart';

class QuestionCategoryRepositoryImpl implements QuestionCategoryRepository {
  final QuestionCategoryDataSource dataSource;

  QuestionCategoryRepositoryImpl({required this.dataSource});

  @override
  Future<List<QuestionCategoryModel>> getCategories() async {
    return dataSource
        .getQuestionCategories()
        .then((dtos) => dtos.map(QuestionCategoryMapper.toModel).toList());
  }
}
