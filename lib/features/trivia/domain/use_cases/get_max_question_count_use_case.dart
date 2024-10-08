import 'dart:math';

import 'package:trivia_riverpod/extensions/int_extension.dart';

class GetMaxQuestionCountUseCase {
  const GetMaxQuestionCountUseCase();

  int call({required int? totalQuestions}) {
    if (totalQuestions == null) return 50;

    return min(totalQuestions.floorToMultipleOf(5), 50);
  }
}
