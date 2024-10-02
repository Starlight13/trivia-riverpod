import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:trivia_riverpod/models/question_category/question_category.dart';
import 'package:trivia_riverpod/providers/dio_provider.dart';

part 'categories_provider.g.dart';

@riverpod
Future<List<QuestionCategory>> categories(Ref ref) async {
  final response = await ref.watch(dioClientProvider).get('/api_category.php');
  final categories = response.data['trivia_categories'] as List;
  return categories.map((e) => QuestionCategory.fromJson(e)).toList();
}
