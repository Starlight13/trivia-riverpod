import 'package:freezed_annotation/freezed_annotation.dart';

class UriStringConverter implements JsonConverter<String, String> {
  const UriStringConverter();

  @override
  String fromJson(String json) => Uri.decodeFull(json);

  @override
  String toJson(String object) => object;
}
