import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:trivia_riverpod/shared/domain/models/trivia_question/trivia_question.dart';

part 'trivia_config_model.freezed.dart';
part 'trivia_config_model.g.dart';

@freezed
class TriviaConfigModel with _$TriviaConfigModel {
  @JsonSerializable(includeIfNull: false)
  factory TriviaConfigModel({
    required int? category,
    required QuestionDifficulty? difficulty,
    required QuestionType? type,
  }) = _TriviaConfigModel;

  factory TriviaConfigModel.fromJson(Map<String, dynamic> json) =>
      _$TriviaConfigModelFromJson(json);
}
