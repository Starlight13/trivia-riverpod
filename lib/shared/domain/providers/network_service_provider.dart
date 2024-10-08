import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:trivia_riverpod/shared/data/remote/dio_network_service.dart';
import 'package:trivia_riverpod/shared/data/remote/network_service.dart';
import 'package:trivia_riverpod/shared/domain/providers/dio_provider.dart';

part 'network_service_provider.g.dart';

@riverpod
NetworkService networkService(NetworkServiceRef ref) {
  final dio = ref.watch(dioClientProvider);
  return DioNetworkService(dio: dio);
}
