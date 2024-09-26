import 'package:get_it/get_it.dart';
import 'package:trivia_riverpod/service/network_service.dart';

final serviceLocator = GetIt.instance;

void setupServiceLocator() {
  serviceLocator.registerSingleton<NetworkService>(NetworkService());
}
