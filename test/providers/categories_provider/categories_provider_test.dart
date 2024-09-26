import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:trivia_riverpod/models/question_category/question_category.dart';
import 'package:trivia_riverpod/providers/categories_provider.dart';
import 'package:trivia_riverpod/service/network_service.dart';

import '../../util.dart';
import 'categories_provider_test.mocks.dart';

@GenerateMocks([
  NetworkService,
])
void main() {
  final categories = [
    const QuestionCategory(id: 1, name: 'category1'),
    const QuestionCategory(id: 2, name: 'category2'),
  ].lock;
  final MockNetworkService networkService = MockNetworkService();

  setUpAll(() {
    GetIt.instance.registerSingleton<NetworkService>(networkService);
  });

  test(
    'Categories provider',
    () async {
      final container = createContainer();
      when(networkService.getCategories()).thenAnswer(
        (_) async => categories.unlock,
      );

      final provider = await container.read(categoriesProvider.future);

      expect(provider.lock, categories);
    },
  );

  test(
    'Categories provider - error thrown',
    () async {
      final container = createContainer();
      when(networkService.getCategories()).thenThrow(
        Exception('An error occurred'),
      );

      expectLater(container.read(categoriesProvider.future), throwsException);
    },
  );

  tearDownAll(() {
    GetIt.instance.reset();
  });
}
