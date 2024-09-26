import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:trivia_riverpod/models/trivia_question/trivia_question.dart';

part 'trivia_config.freezed.dart';
part 'trivia_config.g.dart';

@freezed
class TriviaConfig with _$TriviaConfig {
  @JsonSerializable(includeIfNull: false)
  factory TriviaConfig({
    @Default(10) int amount,
    required int? category,
    required QuestionDifficulty? difficulty,
    required QuestionType? type,
  }) = _TriviaConfig;

  factory TriviaConfig.fromJson(Map<String, dynamic> json) =>
      _$TriviaConfigFromJson(json);
}
