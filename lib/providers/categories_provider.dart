import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:trivia_riverpod/models/question_category/question_category.dart';
import 'package:trivia_riverpod/service/network_service.dart';
import 'package:trivia_riverpod/service/service_locator.dart';

part 'categories_provider.g.dart';

@riverpod
Future<List<QuestionCategory>> categories(Ref ref) {
  final networkService = serviceLocator.get<NetworkService>();
  return networkService.getCategories();
}
