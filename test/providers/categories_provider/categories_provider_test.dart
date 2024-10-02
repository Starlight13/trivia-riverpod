import 'package:dio/dio.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:trivia_riverpod/models/question_category/question_category.dart';
import 'package:trivia_riverpod/providers/categories_provider.dart';
import 'package:trivia_riverpod/providers/dio_provider.dart';

import '../../util.dart';
import 'categories_provider_test.mocks.dart';

@GenerateMocks([
  Dio,
])
void main() {
  final categories = [
    const QuestionCategory(id: 1, name: 'category1'),
    const QuestionCategory(id: 2, name: 'category2'),
  ].lock;

  test(
    'Categories provider',
    () async {
      final dioMock = MockDio();
      final container = createContainer(
        overrides: [dioClientProvider.overrideWithValue(dioMock)],
      );
      when(dioMock.get('/api_category.php')).thenAnswer(
        (_) async => Response(
          data: {
            'trivia_categories': categories.map((c) => c.toJson()).toList(),
          },
          requestOptions: RequestOptions(),
        ),
      );

      final provider = await container.read(categoriesProvider.future);

      expect(provider.lock, categories);
    },
  );

  test(
    'Categories provider - error thrown',
    () async {
      final dioMock = MockDio();
      final container = createContainer(
        overrides: [dioClientProvider.overrideWithValue(dioMock)],
      );
      when(dioMock.get('/api_category.php')).thenThrow(
        Exception('An error occurred'),
      );

      expectLater(container.read(categoriesProvider.future), throwsException);
    },
  );
}
