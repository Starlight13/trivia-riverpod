import 'package:dio/dio.dart';

abstract class NetworkService {
  Future<Response> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
  });
}
