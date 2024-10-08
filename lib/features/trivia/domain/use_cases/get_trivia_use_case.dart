import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:trivia_riverpod/features/trivia/domain/models/trivia_model.dart';
import 'package:trivia_riverpod/features/trivia/domain/repositories/trivia_repository.dart';
import 'package:trivia_riverpod/features/trivia/domain/models/trivia_config_model.dart';

class GetTriviaUseCase {
  final TriviaRepository triviaRepository;

  GetTriviaUseCase(this.triviaRepository);

  Future<TriviaModel> call({
    required int amount,
    required TriviaConfigModel config,
  }) async {
    final questions =
        await triviaRepository.getTrivia(amount: amount, config: config);

    return TriviaModel(
      questionAnswerMap:
          IMap.fromKeys(keys: questions, valueMapper: (k) => null),
    );
  }
}
