import 'package:dio/dio.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:trivia_riverpod/features/trivia/domain/models/question_category_model.dart';
import 'package:trivia_riverpod/features/trivia/presentation/providers/question_categories_provider.dart';
import 'package:trivia_riverpod/shared/data/remote/network_service.dart';
import 'package:trivia_riverpod/shared/domain/providers/network_service_provider.dart';

import '../../util.dart';
import 'categories_provider_test.mocks.dart';

@GenerateMocks([
  NetworkService,
])
void main() {
  final categories = [
    const QuestionCategoryModel(id: 1, name: 'category1'),
    const QuestionCategoryModel(id: 2, name: 'category2'),
  ].lock;

  test(
    'Categories provider',
    () async {
      final networkServiceMock = MockNetworkService();
      final container = createContainer(
        overrides: [
          networkServiceProvider.overrideWithValue(networkServiceMock),
        ],
      );
      when(networkServiceMock.get('/api_category.php')).thenAnswer(
        (_) async => Response(
          data: {
            'trivia_categories': categories.map((c) => c.toJson()).toList(),
          },
          requestOptions: RequestOptions(),
        ),
      );

      final provider = await container.read(questionCategoriesProvider.future);

      expect(provider.lock, categories);
    },
  );

  test(
    'Categories provider - error thrown',
    () async {
      final networkServiceMock = MockNetworkService();
      final container = createContainer(
        overrides: [
          networkServiceProvider.overrideWithValue(networkServiceMock),
        ],
      );
      when(networkServiceMock.get('/api_category.php')).thenThrow(
        Exception('An error occurred'),
      );

      expectLater(
        container.read(questionCategoriesProvider.future),
        throwsException,
      );
    },
  );
}
