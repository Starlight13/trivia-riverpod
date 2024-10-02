import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:trivia_riverpod/env/env.dart';

part 'dio_provider.g.dart';

@Riverpod(keepAlive: true)
Dio dioClient(DioClientRef ref) {
  return Dio(BaseOptions(baseUrl: Env.baseUrl));
}
