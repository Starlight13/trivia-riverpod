import 'package:dio/dio.dart';
import 'package:trivia_riverpod/shared/data/remote/network_service.dart';

class DioNetworkService extends NetworkService {
  final Dio dio;

  DioNetworkService({required this.dio});

  @override
  Future<Response> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
  }) {
    return dio.get(endpoint, queryParameters: queryParameters);
  }
}
