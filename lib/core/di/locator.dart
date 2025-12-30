import 'package:flutter_news_app/core/local/hive_service.dart';
import 'package:flutter_news_app/core/network/api_client.dart';
import 'package:flutter_news_app/data/datasources/local/news_local_data_source.dart';
import 'package:flutter_news_app/data/datasources/local/theme_local_data_source.dart';
import 'package:flutter_news_app/data/datasources/remote/auth_service.dart';
import 'package:flutter_news_app/data/datasources/remote/firestore_service.dart';
import 'package:flutter_news_app/data/datasources/remote/news_api_service.dart';
import 'package:flutter_news_app/core/services/user_service.dart';
import 'package:flutter_news_app/data/repositories/news_repository.dart';
import 'package:flutter_news_app/data/repositories/user_repository.dart';
import 'package:get_it/get_it.dart';

final GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  locator.registerLazySingleton<ApiClient>(() => ApiClientImpl());

  locator.registerLazySingleton<AuthService>(() => AuthService());
  locator.registerLazySingleton<UserService>(() => UserService());
  locator.registerLazySingleton<NewsApiService>(
    () => NewsApiService(locator<ApiClient>()),
  );
  locator.registerLazySingleton<FirestoreService>(() => FirestoreService());

  // local
  locator.registerSingletonAsync<HiveService>(() async {
    final hiveService = HiveService();
    await hiveService.init();
    return hiveService;
  });
  locator.registerLazySingleton<NewsLocalDataSource>(
    () => NewsLocalDataSource(locator<HiveService>().newsBox),
  );
  locator.registerLazySingleton<ThemeLocalDataSource>(
    () => ThemeLocalDataSource(locator<HiveService>().themeBox),
  );

  // repositories
  locator.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
      locator<AuthService>(),
      locator<FirestoreService>(),
      locator<UserService>(),
    ),
  );

  locator.registerLazySingleton<NewsRepository>(
    () => NewsRepositoryImpl(locator<NewsApiService>()),
  );

  await locator.allReady();
}
