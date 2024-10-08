import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:trivia_riverpod/features/trivia/data/mappers/category_question_count_mapper.dart';
import 'package:trivia_riverpod/features/trivia/domain/models/category_question_count_model.dart';
import 'package:trivia_riverpod/features/trivia/presentation/providers/category_question_count_providers.dart';
import 'package:trivia_riverpod/shared/domain/models/trivia_question/trivia_question.dart';
import 'package:trivia_riverpod/shared/domain/providers/dio_provider.dart';

import '../../util.dart';
import 'category_question_count_provider_test.mocks.dart';

@GenerateMocks([
  Dio,
])
void main() {
  final categoryCount = CategoryQuestionCountModel(
    totalQuestionCount: 40,
    totalEasyQuestionCount: 11,
    totalMediumQuestionCount: 22,
    totalHardQuestionCount: 17,
  );

  test('Category question count', () async {
    final dioMock = MockDio();
    when(
      dioMock.get(
        '/api_count.php',
        queryParameters: {'category': 1},
      ),
    ).thenAnswer(
      (_) async => Response(
        data: {
          'category_question_count':
              CategoryQuestionCountMapper.fromModel(categoryCount).toJson(),
        },
        requestOptions: RequestOptions(),
      ),
    );
    final container = createContainer(
      overrides: [
        dioClientProvider.overrideWithValue(dioMock),
      ],
    );
    final provider =
        await container.read(categoryQuestionCountProvider(1).future);

    expect(provider, categoryCount);
  });

  test('Category difficulty question count', () async {
    final container = createContainer(
      overrides: [
        categoryQuestionCountProvider(1).overrideWith((_) => categoryCount),
      ],
    );

    await expectLater(
      container.read(
        categoryQuestionCountForDifficultyProvider(
          categoryId: 1,
          difficulty: null,
        ).future,
      ),
      completion(categoryCount.totalQuestionCount),
    );
    await expectLater(
      container.read(
        categoryQuestionCountForDifficultyProvider(
          categoryId: 1,
          difficulty: QuestionDifficulty.easy,
        ).future,
      ),
      completion(categoryCount.totalEasyQuestionCount),
    );
    await expectLater(
      container.read(
        categoryQuestionCountForDifficultyProvider(
          categoryId: 1,
          difficulty: QuestionDifficulty.medium,
        ).future,
      ),
      completion(categoryCount.totalMediumQuestionCount),
    );

    await expectLater(
      container.read(
        categoryQuestionCountForDifficultyProvider(
          categoryId: 1,
          difficulty: QuestionDifficulty.hard,
        ).future,
      ),
      completion(categoryCount.totalHardQuestionCount),
    );
  });
}
