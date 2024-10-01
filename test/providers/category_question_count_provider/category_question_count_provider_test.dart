import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:trivia_riverpod/models/category_question_count/category_question_count_model.dart';
import 'package:trivia_riverpod/models/trivia_question/trivia_question.dart';
import 'package:trivia_riverpod/providers/category_question_count_provider.dart';
import 'package:trivia_riverpod/service/network_service.dart';

import '../../util.dart';
import 'category_question_count_provider_test.mocks.dart';

@GenerateMocks([
  NetworkService,
])
void main() {
  final MockNetworkService networkService = MockNetworkService();
  final categoryCount = CategoryQuestionCountModel(
    totalQuestionCount: 40,
    totalEasyQuestionCount: 11,
    totalMediumQuestionCount: 22,
    totalHardQuestionCount: 17,
  );

  setUpAll(() {
    GetIt.instance.registerSingleton<NetworkService>(networkService);
  });
  test('Category question count', () async {
    when(networkService.getCategoryQuestionCount(1))
        .thenAnswer((_) async => categoryCount);
    final container = createContainer();
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
      container.read(categoryDifficultyQuestionCountProvider(1, null).future),
      completion(categoryCount.totalQuestionCount),
    );
    await expectLater(
      container.read(
        categoryDifficultyQuestionCountProvider(1, QuestionDifficulty.easy)
            .future,
      ),
      completion(categoryCount.totalEasyQuestionCount),
    );
    await expectLater(
      container.read(
        categoryDifficultyQuestionCountProvider(1, QuestionDifficulty.medium)
            .future,
      ),
      completion(categoryCount.totalMediumQuestionCount),
    );

    await expectLater(
      container.read(
        categoryDifficultyQuestionCountProvider(1, QuestionDifficulty.hard)
            .future,
      ),
      completion(categoryCount.totalHardQuestionCount),
    );
  });
}
