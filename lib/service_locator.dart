import 'package:get_it/get_it.dart';

import 'package:nu3virtual/core/services/user/user_service_api.dart';
import 'package:nu3virtual/core/services/user/user_service_class.dart';
import 'package:nu3virtual/core/services/user/user_service_store.dart';

final getIt = GetIt.instance;

// Note that we are registering StorageService as a lazy singleton.
// It only gets initialized when it’s first used.
// If you want it to be initialized on app startup, then use registerSingleton() instead.
// Since it’s a singleton, you’ll always have the same instance of your service.
setupServiceLocator() {
  getIt.registerLazySingleton<UserServiceApiClass>(() => UserService());
  getIt.registerLazySingleton<UserServiceStoreClass>(() => UserServiceStore());
}
